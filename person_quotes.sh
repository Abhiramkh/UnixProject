#!/bin/bash
mkdir -p quotes
echo -n "Enter the name of the person : "
read a
a=${a,,}
a=${a// /-} 
str1="https://www.brainyquote.com/authors/$a"
str2="$str1-quotes"
curl -s $str2 | grep -e 'view quote' > ./quotes/sample.html
grep -o '<a.*>.*</a>' ./quotes/sample.html | sed 's/<\/a>/\n/g' | sed 's/<a.*>//g' > ./quotes/sample.txt
len=$(wc -l < ./quotes/sample.txt)
if [ $len -lt 2 ]
then
printf "No quotes of this person available \n"
else  
cat ./quotes/sample.txt | sed 's/\&\#39\;/\x27/g' > ./quotes/$a.txt
cat ./quotes/$a.txt
fi
