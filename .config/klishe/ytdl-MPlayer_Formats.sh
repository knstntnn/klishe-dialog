#!/bin/sh

# knn_knstntnn 210603 # thanks to krasnyh
# выбор ytdl-фоматов с последующим воспроизведением в MPlayer. 
# dialog/Xdialog-скрипт-для-"вхождения" ( пр.: под скрипт 'klishe.sh' [один из примеров "юзер-скриптов для klishe"])

if [ -z $DISPLAY ]
  then
    DIALOG=dialog    
  else
    DIALOG=Xdialog   
fi

url="$@"

$DIALOG    --title "инфо1"   --infobox " обработка... ждите 'окно-списка' " 7  50  &

[ -f "/tmp/Ffile" ] && rm /tmp/Ffile

## grep ',' - отсечка строк "без форматов".
while [ ! -f "/tmp/Ffile" ] ; do    ( youtube-dl -F "$url" | grep ',' > /tmp/Ffile )  ; done  |  $DIALOG    --title "инфо1"   --gauge " обработка... ждите 'окно-списка' " 7  50 0

$DIALOG  --title "выбери число(-а) из левой колонки" --textbox  /tmp/Ffile 28 100 

# "выходы"
case $? in

    1)
	echo "Отказ от ввода." ; exit 0 ;;
    255)
	echo "Нажата клавиша ESC." ; rm /tmp/Ffile ; exit 0 ;;
esac

# ручной ввод форматов.
  fInput=` $DIALOG  --stdout --title "вв. число(~a) формата(~ов)"  --inputbox "- из предыдущего вывода \n пр.: 249 или 18+249 \n ( !!! видеоформат - первым ! ).\n --------- \n ...возможно не все форматы сочетаются...\n ( webm+webm=ok, и т.п. ...???) " 22 100 `


# "выходы"
case $? in

    1)
	echo "Отказ от ввода."  ; rm /tmp/Ffile; exit 0 ;;
    255)
	echo "Нажата клавиша ESC." ; rm /tmp/Ffile ; exit 0 ;;
esac


rm /tmp/Ffile  


$DIALOG  --title "инфо2" --infobox "подгужается ...\n ждите 'ok-окно' "  15 50 &


mplay ()
{
 ffmpeg -i "$(youtube-dl -g -f $1 $url)" -i "$(youtube-dl -g -f $2 $url)" -c copy -f $3 - | mplayer -fs -zoom  -cache 10000  -
}
echo "$fInput"
echo $url


mplay $fInput

# обработка ошибок 
# errCode=$(echo "$?")


# if [ "$errCode" -ne "0" ]
#   then
#     $DIALOG   --title "код выхода"   --msgbox " !!! ошибка !!! \n ( код = $errCode ) \n $(cat /tmp/stdoutFile)  "  12 100 

# fi

rm /tmp/stderrFile


