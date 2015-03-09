#!/bin/bash

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
	./apktool/apktool if 'original_files/framework-res.apk'
	./apktool/apktool d 'original_files/SystemUI.apk' -o 'output/SystemUI'
}



checkFiles
decompile