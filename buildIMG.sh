#!/bin/bash

userName="test"
password="abcdefgh"

imgFileSize="12GiB"
imgFileName="alma-xfce-manjaro.img"
timeZone="Asia/Taipei"
mirrorCountry="Taiwan"

removeIMG() {
	local img=$1
	[ -e $img ] && {
		local loopbackDev=$(sudo losetup -j $img | cut -d ':' -f 1)
		[ -n "$loopbackDev" ] && {
			sudo losetup -d $img
		}
		rm -fv $img
	}
}

xfceManjaro() {
	removeIMG $imgFileName

	sudo ALMA_USER=$userName ALMA_USER_PASSWORD=$password TIMEZONE=$timeZone MIRROR_COUNTRY=$mirrorCountry alma create --image $imgFileSize $imgFileName --presets presets
}

xfceManjaro
