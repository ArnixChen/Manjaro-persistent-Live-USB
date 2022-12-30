# Manjaro persistent Live USB
Scripts and presets for building your own Manjaro persistent Live USB with ALMA.

## Usage
### Installation
#### 1. Clone this github repository to your PC.
```
git clone https://github.com/ArnixChen/Manjaro-persistent-Live-USB-with-ALMA.git
```
#### 2. Install [ALMA](https://github.com/r-darwish/topgrade/)(Arch Linux Mobile Appliance).
This can be done by installing the `alma-git` package with pacman. (Or install  alma (AUR package) with pamac)
``` shell
sudo pacman -S alma-git
```
#### 3. Install QEMU(for testing the live USB image).
``` shell
sudo pacman -S qemu-base
```
  
#### 4. Install a VNC Client(for testing the live USB image).
Here I use virt-viewer, you can choose whatever you like.
``` shell
sudo pacman -S virt-viewer
```
### Build Manjaro persistent live usb image
#### 1. Enter the cloned folder and edit buidIMG.sh script to customize the settings to fit your needs.
```
userName="test"
password="abcdefgh"

imgFileSize="12GiB"
imgFileName="alma-xfce-manjaro.img"
timeZone="Asia/Taipei"
mirrorCountry="Taiwan"
```
#### 2. Execute buildIMG.sh
``` shell
./buildIMG.sh
```
  
### Test the newly created image
#### 1. Boot the newly created image with QEMU.
``` shell
./startQemu.sh
```
#### 2. Launch virt-viewer(Remote Viewer) and give it with following connection address.
```
vnc://127.0.0.1:5900
```
Then you can login with your customized username and password which stated in buildIMG.sh.
#### 3. After shuting down the virtual machine of live USB.
Don't forget to switch back the xterminal where you execute ./startQemu.sh and type your password to complete the
loopback device detach process.
  
### Copy the live USB image into your USB stick.
#### 1. Confirm the correct device name of USB stick.
To avoid accidently damage your harddisk, you should reconfirm the device name of your USB stick.
You can use command lsblk twice to compare the list before insert USB stick and after.
```
lsblk
```
#### 2. Image copying. 
You can dd or more fancy utility like dd_rescue alternatively.
```
sudo dd if=alma-xfce-manjaro.img of=<device file name of USB stick>
```
  ex.
```
sudo dd if=alma-xfce-manjaro.img of=/dev/sdc
```

### If you like, your can move /home folder into a separate partition and make it to occupy the rest space of live USB stick.
#### 1. Insert live USB stick which have done the image copying step to your PC.
#### 2. Create new partition which occupies the rest space of live USB stick with gparted. And label it as HOME.
#### 3. Mount live USB stick.
```
mkdir usbstick
sudo mount /dev/sdc3 usbstick  
```
#### 4. Mount the newly created HOME partiton to local folder ./mnt
``` shell
mkdir mnt
sudo mount /dev/sdc4 ./mnt
```
#### 5. Get the UUID of newly created HOME partiton.
``` shell
sudo blkid /dev/sdc4
```
#### 6. Copy all contents in live USB stick's /home folder into ./mnt
``` shell
sudo cp -av usbstick/home ./mnt
```
#### 7. Modify /etc/fstab to make OS to mount newly created HOME partition to /home.
```
UUID=<UUID of newly created HOMD partition from blkid>	/home         	ext4      	rw,noatime	0 1
```
ex. 
```
UUID=6bd4baad-7c50-4b7b-8acd-2027e28c61ab	/         	ext4      	rw,noatime	0 1
UUID=5d070e0d-1a90-4ebf-b380-b360139c79bb	/home         	ext4      	rw,noatime	0 1

UUID=3372-353D      	/boot     	vfat      	rw,noatime,fmask=0027,dmask=0027,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro	0 2
```
#### 8. Unmount all manually mounted partitions on  live USB stick.
``` shell
sudo umount /dev/sdc3
sudo umount /dev/sdc4
```



  
  
  
  
