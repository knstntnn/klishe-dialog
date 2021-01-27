#!/bin/sh

# knn_knstntnn 210127
# скачивание аудио формата 'f 249'
# dialog/Xdialog-скрипт-для-"вхождения" ( пр.: под скрипт 'klishe.sh')

if [ -z $DISPLAY ]
  then
    DIALOG=dialog    
  else
    DIALOG=Xdialog   
fi

url="$@"

$DIALOG   --infobox "скачивается ...\n ждите 'ok-окно' "  7 50 &

youtube-dl -f 249 "$url"  2> /tmp/stderrFile


## !!! вывод stderr --> info-dialog !!!!!

# $DIALOG  --title " код возврата"   --msgbox " $? "  8 60

errCode=$(echo "$?")
if [ "$errCode" -ne "0" ]
  then
    $DIALOG   --title "ошибка"   --msgbox " !!! ошибка !!! \n ( код = $errCode ) \n $(cat /tmp/stdoutFile)  "  12 100 
  else
# ok --msgbox
    $DIALOG  --title "f=249 для $url"   --msgbox "ok \n скачалось ).\n ( в \"\$HOME\" )" 12 100
  
fi

rm /tmp/stderrFile

