#!/bin/bash

# Redirect output to a log file
exec >> /home/pi4r/Desktop/cron2.log 2>&1

# Define the URL of the cryptocurrency website to scrape
URL="https://coinmarketcap.com/currencies/bitcoin/?timestamp=$(date +%s)"

# Fetch the webpage content using curl 
HTML=$(curl -s "$URL")

# Extract the main HTML tag containing all five values
MAIN_TAG=$(echo "$HTML" | grep -Eo '<dd class="sc-f70bb44c-0 bCgkcs base-text">([^<]+)' )

# Extracting and formatting each value separately
# Ratio
RATIO=$(echo "$MAIN_TAG" | sed -n '1p' | sed 's/<[^>]*>//g')

# Circulating Supply
CIRCULATING_SUPPLY=$(echo "$MAIN_TAG" | sed -n '2p' | sed 's/<[^>]*>//g')

# Total Supply
TOTAL_SUPPLY=$(echo "$MAIN_TAG" | sed -n '3p' | sed 's/<[^>]*>//g')

# Max Supply
MAX_SUPPLY=$(echo "$MAIN_TAG" | sed -n '4p' | sed 's/<[^>]*>//g')

# Fully Diluted Market Cap
FULLY_DILUTED_MARKET_CAP=$(echo "$MAIN_TAG" | sed -n '5p' | sed 's/<[^>]*>//g')

# Print the extracted data
echo "Ratio: $RATIO"
echo "Circulating Supply: $CIRCULATING_SUPPLY"
echo "Total Supply: $TOTAL_SUPPLY"
echo "Max Supply: $MAX_SUPPLY"
echo "Fully Diluted Market Cap: $FULLY_DILUTED_MARKET_CAP"

# Store the extracted data in a file
echo "$(date +"%Y-%m-%d %H:%M:%S"),Ratio,$RATIO" >> /home/pi4r/Desktop/cryptocurrency_data3.csv
echo "$(date +"%Y-%m-%d %H:%M:%S"),CirculatingSupply,$CIRCULATING_SUPPLY" >> /home/pi4r/Desktop/cryptocurrency_data3.csv
echo "$(date +"%Y-%m-%d %H:%M:%S"),TotalSupply,$TOTAL_SUPPLY" >> /home/pi4r/Desktop/cryptocurrency_data3.csv
echo "$(date +"%Y-%m-%d %H:%M:%S"),MaxSupply,$MAX_SUPPLY" >> /home/pi4r/Desktop/cryptocurrency_data3.csv
echo "$(date +"%Y-%m-%d %H:%M:%S"),FullyDilutedMarketCap,$FULLY_DILUTED_MARKET_CAP" >> /home/pi4r/Desktop/cryptocurrency_data3.csv
