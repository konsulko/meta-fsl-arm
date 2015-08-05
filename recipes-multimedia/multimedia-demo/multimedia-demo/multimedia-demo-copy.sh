#!/bin/sh

configFile="m2plus.mp4"
configPath="/home/root/"

for DEV in /sys/block/sd*
do
	#check if the device is recognized as USB
	if readlink $DEV | grep -q usb
	then
		#mount the device
		device=`basename $DEV`
		echo "USB device detected: $device"
		echo "Mounting USB device. Please wait..."
		
		#make sure the device in not mounted
		cat /proc/mounts | grep $device
		isDeviceMounted=$?
		if [ $isDeviceMounted -eq 0 ]; then		
			all='*'
			deviceAll=$device$all
			umount /dev/$deviceAll
		fi

		#mount the first partition of the device
		mkdir -p /mnt/
		partition='1'
		devicePartition=$device$partition
		mount /dev/$devicePartition /mnt

		#check if file exists and copy it
		if [ ! -f /mnt/$configFile ]; then
			echo "File not found: $configFile"
			umount /dev/$devicePartition
			continue
		fi

		#check if file is the same at the existing in the home directory
		if [ -f $configPath$configFile ]; then
			checksumMnt=`md5sum /mnt/$configFile | awk '{ print $1 }`
			checksumHome=`md5sum $configPath$configFile | awk '{ print $1 }`
			if [ "$checksumMnt" = "$checksumHome" ]; then
				echo "Files are identical. Skipping..."
				continue
			fi
		fi

		echo "Coping file $configFile. Please wait..."
		mkdir -p $configPath
		cp /mnt/$configFile $configPath
		copyStatus=$?
		if [ $copyStatus -eq 0 ]; then
			echo "File $configFile copied to directory $configPath"
			umount /dev/$devicePartition
			break
		else
			echo "Error: unable to copy file $configFile"
			umount /dev/$devicePartition
		fi
	fi
done

exit 0
