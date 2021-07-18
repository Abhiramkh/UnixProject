#!/bin/bash
#create a directory called data to store the files
mkdir data

# download the web page with cURL
curl  https://support.spatialkey.com/spatialkey-sample-csv-data/ -o ./data/sample.html
#-s to remove the progress bar and -o to save a file
# process the web page with lynx
lynx -dump ./data/sample.html > ./data/sample.txt

# get the urls
cat ./data/sample.txt | grep -e '\.csv$'
#to search for the required csv files

# same command as before, piped into cut, and saved to a file
cat ./data/sample.txt | grep -e '\.csv$' | cut -c 7- > ./data/urls.txt
# see what we got
cat ./data/urls.txt

# get the first url and download with crl
head -n 1 ./data/urls.txt | xargs curl -so ./data/realestate.csv

