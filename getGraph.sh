#!/bin/bash

# Function to create a timestamp
createTimestamp() {
    timestamp=$(date +'%Y-%m-%d %H:%M:%S')
    echo $timestamp
}

# Directory to store the error log file
errorLogDir="/home/pi4r/tracker"

# MySQL database details
dbUser="root"
dbPassword="password"
dbName="crypto_prices_db"

# Fetch the list of currencies from the database
currencies=$(mysql -u $dbUser -p$dbPassword -D $dbName -se "SELECT CurrencyName FROM currencies;")
if [ $? -ne 0 ]; then
    errorMessage="Error: Failed to fetch data from MySQL at $(createTimestamp)"
    echo $errorMessage | tee -a "${errorLogDir}/errorLog.txt"
    exit 1
fi

# Loop through each currency
while read -r currency; do
    # Get CurrencyID
    currencyId=$(mysql -u $dbUser -p$dbPassword -D $dbName -se "SELECT CurrencyID FROM currencies WHERE CurrencyName = '$currency';")

    # Remove old graph file if it exists
    if [ -f "${currency}.png" ]; then
	echo "Old ${currency}.png found. Removing old ${currency}.png file"
        rm "${currency}.png"
    fi

    # Query to fetch prices
    query="SELECT UNIX_TIMESTAMP(TimeTaken) AS timestamp, Price, 24HLowestPrice, 24HHighestPrice, DATE_FORMAT(TimeTaken, '%Y-%m-%d %H:%i:%s') AS datetime FROM prices WHERE CurrencyID = $currencyId;"

    # Execute the query and save the results to a temporary file
    if ! mysql -u $dbUser -p$dbPassword -D $dbName -e "$query" | awk 'NR>1 {print $1,$2,$3,$4,$5}' > "${currency}Prices.txt"; then
        errorMessage="Error: Failed to fetch data fron MySQL at $(createTimestamp)"
	echo $errorMessage | tee -a "${errorLogDir}/errorLog.txt"
        continue
    fi

    # Use gnuplot to create a graph
    if ! gnuplot << EOF
        set terminal png size 1200,600
        set output '${currency}.png'
        set xdata time
        set timefmt "%s"
        set format x "%H:%M\n%d-%m-%Y"
        set xlabel "Time"
        set ylabel "Price (USD)"
        set title "${currency} Price Graph"
        plot "${currency}Prices.txt" using 1:2 with lines title "Price", \
             "${currency}Prices.txt" using 1:3 with lines title "24HLowestPrice", \
             "${currency}Prices.txt" using 1:4 with lines title "24HHighestPrice"
EOF
    then
        errorMessage="Error: Failed to create graph for $currency at $(createTimestamp)"
        echo $errorMessage | tee -a "${errorLogDir}/errorLog.txt"
        rm "${currency}Prices.txt"
        continue
    fi

    # Remove the temporary file
    rm "${currency}Prices.txt"
done <<< "$currencies"
