# Define MySQL credentials and database name
MYSQL_USER="root"
MYSQL_PASSWORD="raspberry4"
MYSQL_DATABASE="test"

# Define CSV file path
CSV_FILE="/home/pi4r/Desktop/cryptocurrency_data.csv"

# Define the SQL statement to create the table
SQL_CREATE_TABLE="CREATE TABLE IF NOT EXISTS cryptocurrency_data (timestamp TIMESTAMP, currency VARCHAR(50), price DECIMAL(10,2));"

# Define the SQL statement to insert data from the CSV file
SQL_INSERT_DATA="LOAD DATA LOCAL INFILE '$CSV_FILE' INTO TABLE cryptocurrency_data FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;"

# Execute SQL statements using the mysql command-line tool
mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -D"$MYSQL_DATABASE" -e "$SQL_CREATE_TABLE"
mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -D"$MYSQL_DATABASE" -e "$SQL_INSERT_DATA"