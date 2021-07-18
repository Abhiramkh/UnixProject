#!/bin/bash
mkdir -p quotes
echo -n "Enter the name of the topic : "
read var
var=${var,,}
str1="https://www.brainyquote.com/topics/$var"
str="$str1-quotes"
curl -s $str1 |  grep '"view quote"\|"view author"' > ./quotes/sample1.html
sed 's/<\/a>//g' ./quotes/sample1.html | sed 's/<a.*>//g' > ./quotes/sample1.txt
len=$(wc -l < ./quotes/sample1.html)
if [ $len -lt 1 ]
then
printf "No quotes on this topic available\n"
else
cat ./quotes/sample1.txt | sed 's/\&\#39\;/\x27/g'| sed '/^$/d' > ./quotes/s1.txt
i=0
cat ./quotes/s1.txt | while read line 
do
   if [ $(($i % 2 )) -eq 0 ]
   then
   	stry="Quote : "
   	strx="${stry} ${line}" 
   	echo $strx | sed 's/:/ :/' >> ./quotes/$var.txt 
   else
   	stry="Author : "
   	strx="$stry$line"
   	echo $strx >> ./quotes/$var.txt 
   fi
   i=$((i+1))	
done
cat ./quotes/$var.txt
fi
