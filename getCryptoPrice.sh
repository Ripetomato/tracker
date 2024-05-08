#!/bin/bash

# Connect to the webpage with Bitcoin prices
bitcoinUrl="https://www.coindesk.com/price/bitcoin/"
bitcoinContent=$(curl -s "$bitcoinUrl")

# Pattern for the Bitcoin price
bitcoinPricePattern='<span class="currency-pricestyles__Price-sc-1v249sx-0 fcfNRE">([^<]+)</span>'
# Find and clean the Bitcoin price
bitcoinPrice=$(echo "$bitcoinContent" | grep -oP "$bitcoinPricePattern" | sed -E 's/<\/?span[^>]*>//g')

# Pattern for the 24H lowest Bitcoin price
lowestBitcoinPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'
# Find and clean the 24H lowest Bitcoin price
lowestBitcoinPrice=$(echo "$bitcoinContent" | grep -oP "$lowestBitcoinPricePattern" | head -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/')

# Pattern for the 24H highest Bitcoin price
highestBitcoinPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'
# Find and clean the 24H highest Bitcoin price
highestBitcoinPrice=$(echo "$bitcoinContent" | grep -oP "$highestBitcoinPricePattern" | tail -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/')

#------------------------------------------------------------------------------------------------------------------------------

# Connect to the webpage with Ethereum prices
ethereumUrl="https://www.coindesk.com/price/ethereum/"
ethereumContent=$(curl -s "$ethereumUrl")

# Pattern for the Ethereum price
ethereumPricePattern='<span class="currency-pricestyles__Price-sc-1v249sx-0 fcfNRE">([^<]+)</span>'
# Find and clean the Ethereum price
ethereumPrice=$(echo "$ethereumContent" | grep -oP "$ethereumPricePattern" | sed -E 's/<\/?span[^>]*>//g')

# Pattern for the 24H lowest Ethereum price
lowestEthereumPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'
# Find and clean the 24H lowest Ethereum price
lowestEthereumPrice=$(echo "$ethereumContent" | grep -oP "$lowestEthereumPricePattern" | head -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/')

# Pattern for the 24H highest Ethereum price
highestEthereumPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'
# Find and clean the 24H highest Ethereum price
highestEthereumPrice=$(echo "$ethereumContent" | grep -oP "$highestEthereumPricePattern" | tail -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/')


# Store the results in a text file
echo "Bitcoin Price: $bitcoinPrice" > /home/ripetomato/tracker/crypto_prices.txt
echo "24H Lowest Bitcoin Price: $lowestBitcoinPrice" >> /home/ripetomato/tracker/crypto_prices.txt
echo "24H Highest Bitcoin Price: $highestBitcoinPrice" >> /home/ripetomato/tracker/crypto_prices.txt

echo "Ethereum Price: $ethereumPrice" >> /home/ripetomato/tracker/crypto_prices.txt
echo "24H Lowest Ethereum Price: $lowestEthereumPrice" >> /home/ripetomato/tracker/crypto_prices.txt
echo "24H Highest Ethereum Price: $highestEthereumPrice" >> /home/ripetomato/tracker/crypto_prices.txt

: <<EOF
# Show the results in the terminal (to check if the data extracted is correct)
echo "Bitcoin Price: $bitcoinPrice"
echo "24H Lowest Bitcoin Price: $lowestBitcoinPrice"
echo "24H Highest Bitcoin Price: $highestBitcoinPrice"

echo "Ethereum Price: $ethereumPrice"
echo "24H Lowest Ethereum Price: $lowestEthereumPrice"
echo "24H Highest Ethereum Price: $highestEthereumPrice"
EOF
