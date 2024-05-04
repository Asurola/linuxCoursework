#!/bin/bash

# Redirect output to a log file
exec >> /home/pi4r/Desktop/linuxCoursework/cron4.log 2>&1

# Define the URL of the cryptocurrency website to scrape
URL="https://coinmarketcap.com/currencies/ethereum/?timestamp=$(date +%s)"

# Fetch the webpage content using curl 
HTML=$(curl -s "$URL")

# Extract the main HTML tag containing all five values
MAIN_TAG=$(echo "$HTML" | grep -Eo '<dd class="sc-f70bb44c-0 bCgkcs base-text">([^<]+)' )

# Extracting and formatting each value separately
# Ratio
RATIO=$(echo "$MAIN_TAG" | sed -n '1p' | sed 's/<[^>]*>//g' | tr -d '%')

# Circulating Supply
CIRCULATING_SUPPLY=$(echo "$MAIN_TAG" | sed -n '2p' | sed 's/<[^>]*>//g' | tr -d 'ETH,')

# Total Supply
TOTAL_SUPPLY=$(echo "$MAIN_TAG" | sed -n '3p' | sed 's/<[^>]*>//g' | tr -d 'ETH,')

# Max Supply
MAX_SUPPLY=$(echo "$MAIN_TAG" | sed -n '4p' | sed 's/<[^>]*>//g' | tr -d 'ETH,')

# Fully Diluted Market Cap
FULLY_DILUTED_MARKET_CAP=$(echo "$MAIN_TAG" | sed -n '5p' | sed 's/<[^>]*>//g' | tr -d 'ETH,$')

# Print the extracted data
echo "$RATIO"
echo "$CIRCULATING_SUPPLY"
echo "$TOTAL_SUPPLY"
echo "$MAX_SUPPLY"
echo "$FULLY_DILUTED_MARKET_CAP"

# Store the extracted data in a file
echo "$(date +"%Y-%m-%d %H:%M:%S"),$RATIO",$CIRCULATING_SUPPLY",$TOTAL_SUPPLY",$MAX_SUPPLY",$FULLY_DILUTED_MARKET_CAP" >> /home/pi4r/Desktop/linuxCoursework/EthTracker2.csv
