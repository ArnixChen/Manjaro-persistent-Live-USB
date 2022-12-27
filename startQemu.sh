#!/bin/bash

img=alma-xfce-manjaro.img

sudo losetup -f $img
loopbackDev=$(sudo losetup -j $img| cut -d ':' -f 1)

[ -n $loopbackDev ] && {
	sudo alma qemu $loopbackDev
	echo Enter password to remove loopback device for ALMA
	sudo losetup -d $loopbackDev
}
