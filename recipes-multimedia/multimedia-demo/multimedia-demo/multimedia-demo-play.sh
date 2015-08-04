#!/bin/sh

configFile="/home/root/m2plus.mp4"

if [ ! -f $configFile ]; then
	echo "File not found: $configFile"
	exit 1
fi

while true; do gst-play-1.0 --audiosink="pulsesink" --videosink=autodetect $configFile; done


exit 0
