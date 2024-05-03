#!/bin/bash

# Redirect output to a log file
exec >> /home/pi4r/Desktop/cron.log 2>&1

# Define the URL of the cryptocurrency website to scrape
URL="https://coinmarketcap.com/currencies/bitcoin/?timestamp=$(date +%s)"

# Fetch the webpage content using curl 
HTML=$(curl -s "$URL")

# Extract the Bitcoin price (text content within the span)
PRICE=$(echo "$HTML" | grep -Eo '<span class="sc-f70bb44c-0 jxpCgO base-text">([^<]+)' | cut -d '>' -f2)

# Remove commas and dollar sign from the price value
PRICE=$(echo "$PRICE" | tr -d ',\$')

# Print the extracted data
echo "Bitcoin Price: $PRICE"

# Store the extracted data in a file
echo "$(date +"%Y-%m-%d %H:%M:%S"),Bitcoin,$PRICE" >> /home/pi4r/Desktop/cryptocurrency_data.csv