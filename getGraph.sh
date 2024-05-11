#!/bin/bash

# MySQL database details
dbUser="root"
dbPassword="password"
dbName="crypto_prices_db"

# Fetch the list of currencies from the database
currencies=$(mysql -u $dbUser -p$dbPassword -D $dbName -se "SELECT CurrencyName FROM currencies;")

# Loop through each currency
while read -r currency; do
    # Get CurrencyID
    currencyId=$(mysql -u $dbUser -p$dbPassword -D $dbName -se "SELECT CurrencyID FROM currencies WHERE CurrencyName = '$currency';")

    # Query to fetch prices
    query="SELECT UNIX_TIMESTAMP(TimeTaken) AS timestamp, Price, 24HLowestPrice, 24HHighestPrice, DATE_FORMAT(TimeTaken, '%Y-%m-%d %H:%i:%s') AS datetime FROM prices WHERE CurrencyID = $currencyId;"

    # Execute the query and save the results to a temporary file
    mysql -u $dbUser -p$dbPassword -D $dbName -e "$query" | awk 'NR>1 {print $1,$2,$3,$4,$5}' > "${currency}Prices.txt"

    # Use gnuplot to create a graph
    gnuplot << EOF
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

    # Remove the temporary file
    rm "${currency}Prices.txt"
done <<< "$currencies"
