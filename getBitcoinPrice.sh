#!/bin/bash

url="https://www.coindesk.com/price/bitcoin/"
content=$(curl -s "$url")

# Pattern for the Bitcoin price
pricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'

# Find and clean the Bitcoin price
price=$(echo "$content" | grep -oP "$pricePattern" | sed -E 's/.*\$([0-9,\.]+)<.*/\1/')

# Pattern for the 24H lowest rate
lowestPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'

# Find and clean the 24H lowest price
lowestPrice=$(echo "$content" | grep -oP "$lowestPricePattern" | sed -E 's/.*\$([0-9,\.]+)<.*/\1/')

# Pattern for the 24H highest rate
highestPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'

# Find and clean the 24H highest price
highestPrice=$(echo "$content" | grep -oP "$highestPricePattern" | sed -E 's/.*\$([0-9,\.]+)<.*/\1/')

# Store the results in a text file
echo "Bitcoin Price: $price" > /home/ripetomato/tracker/bitcoin_prices.txt
echo "24H Lowest Price: $lowestPrice" >> /home/ripetomato/tracker/bitcoin_prices.txt
echo "24H Highest Price: $highestPrice" >> /home/ripetomato/tracker/bitcoin_prices.txt
