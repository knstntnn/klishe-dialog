
#!/bin/sh
# klishe.sh
# (прошлое имя - klisheChooseScript.sh)
# --knn 200814
#


## check
echo -e `xsel -p -o `> /tmp/klishe.txt;
  mh1=$(cat /tmp/klishe.txt)

## если нету - вторичный
if [ -z "$mh1" ]
  then

    echo -e `xsel -s -o `> /tmp/klishe.txt;

      mh1=$(cat /tmp/klishe.txt);    
fi 

## если нету - clipboard
if [ -z "$mh1" ]
  then

    echo -e `xsel -b -o `> /tmp/klishe.txt;

      mh1=$(cat /tmp/klishe.txt);    
fi

# ----
if [ -z "$mh1" ]
  then

    echo -e `xsel -z -o `> /tmp/klishe.txt;

      mh1=$(cat /tmp/klishe.txt);    
fi

if [ ! -z "$@" ] 
 then  
      mh1=$(echo -n "$@")  
fi



rm /tmp/klishe.txt


## ~= очистка буферов
## --? xsel -sc
xsel -c
xsel -bc
#--xsel -kc
#--xsel -kc
#--xsel -sc

# DIALOG=dialog (изначальн)

# w-dialog

if [ -z $DISPLAY ]
  then
    DIALOG=dialog    
  else
    DIALOG=Xdialog   
fi


if [ $TERM = linux ]; then 
  dir=.tty/
fi

if [ $TERM = screen.linux ] ; then 
  dir=.screen/
fi



if [ $DISPLAY ]
  then
dir=
fi



trgtTxt=`$DIALOG   --stdout --title "'klishe' вв. целев. текст"  --inputbox "пусто = $mh1" 10 90 `

case $? in
      0)
      echo "Выбран ....";;
    1)
	echo "Отказ от ввода." ; exit 0;; 
    255)
	echo "Нажата клавиша ESC."; exit 0;; 
 esac




 [ -z "$trgtTxt" ] && trgtTxt="$mh1"

 


trgtScript=`$DIALOG --stdout --title "выбор для: $trgtTxt" --fselect $HOME/.config/klishe/$dir 30 90`



##### закмнт 201006
$trgtScript "$trgtTxt"
