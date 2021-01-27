#!/bin/sh

# knn_knstntnn 210127
# выбор ytdl-фоматов с последующим скачиванием 
# dialog/Xdialog-скрипт-для-"вхождения" ( пр.: под скрипт 'klishe.sh' [один из примеров "юзер-скриптов для klishe"])

if [ -z $DISPLAY ]
  then
    DIALOG=dialog    
  else
    DIALOG=Xdialog   
fi

url="$@"

$DIALOG    --title "инфо1"   --infobox " обработка... ждите 'окно-списка' " 7  50  &

## grep ',' - отсечка строк "без форматов".
  youtube-dl -F "$url" | grep ',' > /tmp/Ffile

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


$DIALOG  --title "инфо2" --infobox "скачивается ...\n ждите 'ok-окно' "  7 50 &

youtube-dl -f "$fInput" "$url" 2> /tmp/stderrFile 

# обработка ошибок 
errCode=$(echo "$?")


if [ "$errCode" -ne "0" ]
  then
    $DIALOG   --title "ошибка"   --msgbox " !!! ошибка !!! \n ( код = $errCode ) \n $(cat /tmp/stdoutFile)  "  12 100 
  else
# ok --msgbox
    $DIALOG  --title "f=$fInput для $url"   --msgbox "ok \n скачалось )\n \" (в \"\$HOME\" )" 12 100
fi

rm /tmp/stderrFile
