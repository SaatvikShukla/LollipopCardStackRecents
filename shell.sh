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
		./apktool/apktool b 'output/SystemUI' 'status_bar_recent_panel_item.xml'
	fi
}

modify ()
{
	cd  output/SystemUI/res/layout 
	line=`sed -n 2p 'status_bar_recent_panel.xml'`
	echo $line
	echo ""
	line="$line android:rotationX="-10.0""
	echo $line
	line1=`sed '2 c\$line' 'status_bar_recent_panel.xml'`
	echo $line1
	cd ../../../..
}

checkFiles
decompile
modify
#recompile