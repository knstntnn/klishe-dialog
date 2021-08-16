#!/bin/sh

# knn_knstntnn 210728
# выбор ytdl-фоматов с последующим воспроизведением в MPV. 
# dialog/Xdialog-скрипт-для-"вхождения" ( пр.: под скрипт 'klishe.sh' [один из примеров "юзер-скриптов для klishe"])

## !! dialog-запрос на выбор плеера


if [ -z $DISPLAY ]
  then
    DIALOG=dialog    
  else
    DIALOG=Xdialog   
fi

url="$@"

# $DIALOG    --title "инфо1"   --infobox " обработка... ждите 'окно-списка' " 7  50  &
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

#########
extnsn="webm"
# --default-item


# ручной ввод форматов.
  fInput=` $DIALOG  --stdout --title "вв. число(~a) формата(~ов)"  --inputbox "- из предыдущего вывода \n пр.: 249 302 webm .\n --------- \n ...возможно не все форматы сочетаются...\n ( webm+webm=ok, и т.п. ...???) "    22 100  " ${extnsn}" `



#########
# !!! пробовать добавить - если пустой ввод ... ( можно попробовать - "дефолт" $fComplex=$(echo "f $fInput")


# "выходы"
case $? in

    1)
	echo "Отказ от ввода."  ; rm /tmp/Ffile; exit 0 ;;
    255)
	echo "Нажата клавиша ESC." ; rm /tmp/Ffile ; exit 0 ;;
esac


rm /tmp/Ffile  


## Starting playback...

 $DIALOG  --title "инфо2" --infobox "подгружается ...\n ждите 'MPV' "  15 50  

### $DIALOG  --title "инфо2" --gauge "подгружается ...\n ждите 'ok-окно' "  15 50 0 

###  $DIALOG  --title "инфо2" --msgbox "подгружается ...\n ждите 'MPlayer' "  15 50 &

###############################
mplay ()
{
 ffmpeg -i "$(youtube-dl -g -f $1 $url)" -i "$(youtube-dl -g -f $2 $url)" -c copy -f "$3" - | mpv -
}
###############


echo "$fInput"
echo $url

# chk=1
# mplay $fInput >  /tmp/of | while [ ! -eq "${chk}" = "Press" ] ; do  chk="$(cat /tmp/of | grep 'Press')" ;  $DIALOG  --gauge "инфо2"  "подгружается ...\n ждите 'ok-окно' "  15 50 0 ; done


mplay $fInput 
  
# rm /tmp/of

# обработка ошибок 
# errCode=$(echo "$?")


# if [ "$errCode" -ne "0" ]
#   then
#     $DIALOG   --title "код выхода"   --msgbox " !!! ошибка !!! \n ( код = $errCode ) \n $(cat /tmp/stdoutFile)  "  12 100 

# fi

# доб-ть проверку налич. /tmp/stderrFile  ... или убрать 'rm /tmp/stderrFile" - ? откуда взято ?

rm /tmp/stderrFile

