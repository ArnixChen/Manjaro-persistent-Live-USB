#!/bin/bash

imgFileName=$(cat buildIMG.sh | /usr/bin/grep ^imgFileName | cut -d '=' -f 2 | sed -e 's/"//g')

sudo losetup -f $imgFileName
loopbackDev=$(sudo losetup -j $imgFileName| cut -d ':' -f 1)

[ -n $loopbackDev ] && {
	sudo alma qemu $loopbackDev
	echo Enter password to detach $imgFileName from loopback device
	sudo losetup -d $loopbackDev
}
