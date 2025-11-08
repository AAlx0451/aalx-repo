#!/bin/sh

echo Hello! This utility will guide you how to add user on iOS
sleep 2
echo Hope you installed Vim...
sleep 2
echo "You did? [y/n]"
read if
if [[ "$if" == "y" || "$if" == "Y" ]]; then
	echo Okey, next...
else
	echo "No way to continue, sorry :("
	exit 1
fi

sleep 2

echo Okey, now you should add your user
echo "Tip! Add a newline in insert mode, then yy -> P in normal mode to Copy-Paste structure"
echo "Then change you home dir, pid (502 recommended (first number)), guid (remember it!!! 0 or 502. it's nessesary e. g. for sudo) and shell (replace /bin/sh with /bin/bash, sh is too POSIX). password should be *"
sleep 20
echo 'Then :wq and "n"'
sleep 5
vipw
echo Congrats!
echo "Now enter your home dir please (absolute, e. g. /var/lina)"
read path
mkdir -p $path
echo Home dir created successfully
echo "Now add your group (or add you to wheel if 0. the same as passwd)"
sleep 2
vi /etc/group
echo Congrats!
echo "Now you can login with 'su - username'. Don't forget to set password with 'passwd username'"
