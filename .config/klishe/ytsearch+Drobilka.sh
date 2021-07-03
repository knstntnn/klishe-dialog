#!/bin/sh
##   knn_knstntnn 
##  
## поиск по ютубу ч/з "ytdl-ytsearch" с переводом результатов в *.m3u
## 

q=$(echo "${@}")

# $ytsNum - кол-во "первых результатов выдачи".
 ytsNum=10

youtube-dl   --get-id  -e   --flat-playlist  ytsearch"${ytsNum}":"${q}"  |  sed  "2~2{s/^/https\:\/\/youtu\.be\//}" > /tmp/yts.m3u

date=$(date +%F_%H-%M)

mkdir -p /$HOME/yts-$date/dev


sed  "1~2{s/^/#EXTINF:,/}" /tmp/yts.m3u > /$HOME/yts-$date/dev/yts.m3u

rm /tmp/yts.m3u

echo /$HOME/yts-$date/ > /tmp/inputCat

echo $HOME/yts-$date/dev/yts.m3u > /tmp/inputM3u

. /usr/share/de-catenator/Drobilka_plus-IP-hdrs.sh










