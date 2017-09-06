#!/bin/bash

# Сценарий цепляется на горячие клавиши и по их нажатию
# с помощью translate-shell (https://github.com/soimort/translate-shell)
# переводит выделенный текст с русского на английский или с любого языка на русский
# и выводит перевод во всплывающем окне, одновременно добавляя его в /tmp/trans.txt

# The script bind to hotkeys translates by pressing them the selected text 
# via translate-shell (https://github.com/soimort/translate-shell) 
# from Russian into English or from any language into Russian 
# and displays the translation like a system notification, adding it to /tmp/trans.txt at the same time

# Arch based depends install: $ yaourt -S translate-shell libnotify xclip 

    notify-send -i dialog-question "Ищу перевод..." " "

	TEXT=$(xclip -s p -o)
	IDENT=$(translate-shell -id "$TEXT" | grep Code | grep ru)
	
	if [ "$IDENT" ]; then
	
	    TRANS=$(translate-shell -b -t en "$TEXT" -output $HOME/.trans.txt)
	
	else
	
	    TRANS=$(translate-shell -b "$TEXT" -output $HOME/.trans.txt)
	
	fi
	
	TRAX=$(cat $HOME/.trans.txt)
	TRAN=$(echo -e "$TRAX \n" >> /tmp/trans.txt)

	cp /dev/null $HOME/.trans.txt
	$TRANS
	
	if [ "$TRAX" ]; then
	  
	   notify-send -i dialog-information "ПЕРЕВОД:" "$TRAX"
	   $TRAN
	   	   
	else
	
	    notify-send -i dialog-error -t 7000 "ОШИБКА:" "Сервис не доступен"
	    
	fi
	
