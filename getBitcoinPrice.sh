url="https://www.coindesk.com/price/bitcoin/"
content=$(curl -s "$url")

# Pattern of the current price
currentPricePattern='<span class="currency-pricestyles__Price-sc-1v249sx-0 fcfNRE">([0-9,\.]+)</span>'

# Find and clean the current price
result=$(echo "$content" | grep -oP "$currentPricePattern" | sed -E 's/.*>([0-9,.]+)<.*/\1/')

# Error handling for the current price
if [ -z "$result" ]; then
    echo "Error: Current Price not found or pattern mismatch"
else
    echo "Current Price:"
    echo "$result"
fi


# Pattern for the 24H lowest and highest rates
dayRatePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)<\/span>.*<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)<\/span>'

# Find and clean the 24H lowest and highest rates
result=$(echo "$content" | grep -oP "$dayRatePattern" | sed -E 's/.*\$([0-9,\.]+)<\/span>.*<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)<\/span>.*/\1\n\2/')

# Error handling for the 24H lowest and highest rates
if [ -z "$result" ]; then
    echo "Error: 24H Lowest and Highest Rates not found or pattern mismatch"
else
    prices=($result)
    echo "24H Lowest Rrice:"
    echo "${prices[0]}"
    echo "24H Highest Rrice:"
    echo "${prices[1]}"
fi







