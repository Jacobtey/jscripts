#!/bin/bash

# Сценарий с помощью translate-shell (https://github.com/soimort/translate-shell)
# переводит выделенный текст с русского на английский или с любого языка на русский
# и выводит перевод как системное уведомление, одновременно добавляя его 
# в накопитель /tmp/trans.txt и буфер обмена

# Задать сочетание клавиш на запуск

# translate-shell libnotify xclip 

 notify-send -i dialog-question -t 2000 "Ищу перевод..." " "

    cp /dev/null $HOME/.trans.txt
    TEXT=$(xclip -o)
    IDENT=$(translate-shell -id "$TEXT" | grep Code | grep ru)
	
	if [ "$IDENT" ]; then
	
    TRANS=$(translate-shell -b -t en "$TEXT" -o $HOME/.trans.txt)
	
	else
	
    TRANS=$(translate-shell -b "$TEXT" -o $HOME/.trans.txt)
	
	fi
	
	$TRANS

    TRAX=$(cat $HOME/.trans.txt)

	if [ "$TRAX" ]; then
	  
notify-send -i dialog-information "ПЕРЕВОД:" "$TRAX"
	
	echo -e "$TRAX \n" >> /tmp/trans.txt
	xclip -i $HOME/.trans.txt -selection clipboard
	   	   
	else
	
notify-send -i dialog-error -t 7000 "ОШИБКА: Отсутствует перевод" "Нет связи с сервисом \n или выделена пустая строка"
	    
	fi
	
