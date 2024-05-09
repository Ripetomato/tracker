#!/bin/bash

# Connect to the webpage with Bitcoin prices
bitcoinUrl="https://www.coindesk.com/price/bitcoin/"
bitcoinContent=$(curl -s "$bitcoinUrl")

# Pattern for the Bitcoin price
bitcoinPricePattern='<span class="currency-pricestyles__Price-sc-1v249sx-0 fcfNRE">([^<]+)</span>'
# Find and clean the Bitcoin price
bitcoinPrice=$(echo "$bitcoinContent" | grep -oP "$bitcoinPricePattern" | sed -E 's/<\/?span[^>]*>//g' | tr -d ',')

# Pattern for the 24H lowest Bitcoin price
lowestBitcoinPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'
# Find and clean the 24H lowest Bitcoin price
lowestBitcoinPrice=$(echo "$bitcoinContent" | grep -oP "$lowestBitcoinPricePattern" | head -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/' | tr -d ',')

# Pattern for the 24H highest Bitcoin price
highestBitcoinPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'
# Find and clean the 24H highest Bitcoin price
highestBitcoinPrice=$(echo "$bitcoinContent" | grep -oP "$highestBitcoinPricePattern" | tail -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/' | tr -d ',')

#====================================================================================================================================================================================================

# Connect to the webpage with Ethereum prices
ethereumUrl="https://www.coindesk.com/price/ethereum/"
ethereumContent=$(curl -s "$ethereumUrl")

# Pattern for the Ethereum price
ethereumPricePattern='<span class="currency-pricestyles__Price-sc-1v249sx-0 fcfNRE">([^<]+)</span>'
# Find and clean the Ethereum price
ethereumPrice=$(echo "$ethereumContent" | grep -oP "$ethereumPricePattern" | sed -E 's/<\/?span[^>]*>//g' | tr -d ',')

# Pattern for the 24H lowest Ethereum price
lowestEthereumPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'
# Find and clean the 24H lowest Ethereum price
lowestEthereumPrice=$(echo "$ethereumContent" | grep -oP "$lowestEthereumPricePattern" | head -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/' | tr -d ',')

# Pattern for the 24H highest Ethereum price
highestEthereumPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'
# Find and clean the 24H highest Ethereum price
highestEthereumPrice=$(echo "$ethereumContent" | grep -oP "$highestEthereumPricePattern" | tail -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/' | tr -d ',')

#====================================================================================================================================================================================================

# Connect to the webpage with Binance Coin prices
binanceUrl="https://www.coindesk.com/price/binance-coin/?_gl=1*nqhlxd*_up*MQ..*_ga*NDk0NzUyMDE3LjE3MTUxNzExNDQ.*_ga_VM3STRYVN8*MTcxNTE3MTE0NC4xLjAuMTcxNTE3MTE0NC4wLjAuMTQzODYyMDUw"
binanceContent=$(curl -s "$binanceUrl")

# Pattern for the Binance Coin price
binancePricePattern='<span class="currency-pricestyles__Price-sc-1v249sx-0 fcfNRE">([^<]+)</span>'

# Find and clean the Binance Coin price
binancePrice=$(echo "$binanceContent" | grep -oP "$binancePricePattern" | sed -E 's/<\/?span[^>]*>//g' | tr -d ',')

# Pattern for the 24H lowest Binance Coin price
lowestBinancePricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'

# Find and clean the 24H lowest Binance Coin price
lowestBinancePrice=$(echo "$binanceContent" | grep -oP "$lowestBinancePricePattern" | head -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/' | tr -d ',')

# Pattern for the 24H highest Binance Coin price
highestBinancePricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'

# Find and clean the 24H highest Binance Coin price
highestBinancePrice=$(echo "$binanceContent" | grep -oP "$highestBinancePricePattern" | tail -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/' | tr -d ',')

#====================================================================================================================================================================================================

# Connect to the webpage with Solana prices
solanaUrl="https://www.coindesk.com/price/solana/?_gl=1*1w7qejl*_up*MQ..*_ga*NDk0NzUyMDE3LjE3MTUxNzExNDQ.*_ga_VM3STRYVN8*MTcxNTE3MTE0NC4xLjEuMTcxNTE3MTE2Ny4wLjAuMTQzODYyMDUw"
solanaContent=$(curl -s "$solanaUrl")

# Pattern for the Solana price
solanaPricePattern='<span class="currency-pricestyles__Price-sc-1v249sx-0 fcfNRE">([^<]+)</span>'

# Find and clean the Solana price
solanaPrice=$(echo "$solanaContent" | grep -oP "$solanaPricePattern" | sed -E 's/<\/?span[^>]*>//g' | tr -d ',')

# Pattern for the 24H lowest Solana price
lowestSolanaPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'

# Find and clean the 24H lowest Solana price
lowestSolanaPrice=$(echo "$solanaContent" | grep -oP "$lowestSolanaPricePattern" | head -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/' | tr -d ',')

# Pattern for the 24H highest Solana price
highestSolanaPricePattern='<span class="typography__StyledTypography-sc-owin6q-0 dtjHgI">\$([0-9,\.]+)</span>'

# Find and clean the 24H highest Solana price
highestSolanaPrice=$(echo "$solanaContent" | grep -oP "$highestSolanaPricePattern" | tail -n 1 | sed -E 's/.*\$([0-9,\.]+)<.*/\1/' | tr -d ',')

#====================================================================================================================================================================================================

# MySQL database details
db_user="root"
db_password="password"
db_name="crypto_prices_db"

# Insert Bitcoin prices into MySQL table
mysql -u "$db_user" -p"$db_password" "$db_name" -e \
"INSERT INTO prices (CurrencyName, Price, 24HLowestPrice, 24HHighestPrice) \
VALUES ('Bitcoin', '$bitcoinPrice', '$lowestBitcoinPrice', '$highestBitcoinPrice');"

# Insert Ethereum prices into MySQL table
mysql -u "$db_user" -p"$db_password" "$db_name" -e \
"INSERT INTO prices (CurrencyName, Price, 24HLowestPrice, 24HHighestPrice) \
VALUES ('Ethereum', '$ethereumPrice', '$lowestEthereumPrice', '$highestEthereumPrice');"

# Insert Binance Coin prices into MySQL table
mysql -u "$db_user" -p"$db_password" "$db_name" -e \
"INSERT INTO prices (CurrencyName, Price, 24HLowestPrice, 24HHighestPrice) \
VALUES ('Binance Coin', '$binancePrice', '$lowestBinancePrice', '$highestBinancePrice');"

# Insert Ethereum prices into MySQL table
mysql -u "$db_user" -p"$db_password" "$db_name" -e \
"INSERT INTO prices (CurrencyName, Price, 24HLowestPrice, 24HHighestPrice) \
VALUES ('Solana', '$solanaPrice', '$lowestSolanaPrice', '$highestSolanaPrice');"
