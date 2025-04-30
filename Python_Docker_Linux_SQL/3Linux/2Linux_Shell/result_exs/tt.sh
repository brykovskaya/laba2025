#!/usr/bin/bash
echo "Поехали!"
count=0     #counting all files
xcount=0    #counting executeable files
total=0     #counting total space used
temp=0      #holding place for file being checked


while read linode lrights dummy lsize  lmonth lday dummy lfname ;
do
(( count ++ ))
(( total += lsize ))
[[ "$lrights" == *x* ]] && (( xcount ++ ))
done < $1


echo "Количество файлов "$count" и они занимают "$total" bytes."
echo
echo "Исполняемых файлов: "$xcount" "