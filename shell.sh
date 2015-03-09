#!/bin/sh

# Saatvik Shukla
# Mon, March 9 2015
# 1643hrs IST

# To change the recents layout to something like LP

##	Put your framework-res.apk and SystemUI.apk
## into the folder Original_files
## and run the script

checkFiles ()
{
	echo "Checking for the files"
	echo "$PWD/original_files/framework-res.apk"
	if [ -e "$PWD/original_files/framework-res.apk" ] && [ -e "$PWD/original_files/SystemUI.apk" ] 
	then
		echo "Files present. Continuing....."
	else
		echo "SystemUI.apk or framework-res.apk not present. Check the files."
		exit
	fi	
}

decompile ()
{
	echo "Decompiling The SystemUI.apk"
	#./apktool/apktool if 'original_files/framework-res.apk'
	./apktool/apktool d -f 'original_files/SystemUI.apk' -o 'output/SystemUI'
}

recompile ()
{
	if [ -d 'output/SystemUI' ]
	then
		./apktool/apktool b 'output/SystemUI' 'status_bar_recent_panel_item.xml' -o 'SystemUI.apk'
	fi
}

modify ()
{
	if [ -e "$PWD/output/SystemUI/res/layout/status_bar_recent_panel_item.xml" ]
	then
		sed -i '2 s|$| android:rotationX="-10.0"|' output/SystemUI/res/layout/status_bar_recent_panel_item.xml #acc to thread
	else
		sed -i '2 s|$| android:rotationX="-10.0"|' output/SystemUI/res/layout/status_bar_recent_item.xml       #acc to Sony stock
	fi
	
	if [ -e "$PWD/output/SystemUI/res/layout/status_bar_recent_panel.xml" ]
	then
		sed -i '2 s|$| android:rotationX="10.0"|' output/SystemUI/res/layout/status_bar_recent_panel.xml #acc to thread
	fi
}

checkFiles
decompile
modify
recompile