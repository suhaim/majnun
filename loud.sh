#!/bin/bash 
# script to react when volume thresholds have been met
thresh=4
while [ 1 ]
do
  arecord -D plughw:1,0 -f cd -t wav -d 2 -r 16000 /dev/shm/noise.wav
  volume=$(sox /dev/shm/noise.wav -n stats -s 16 2>&1 | awk '/^Max\ level/ {print $3}'| tr -d ' ')
  volumeint=${volume/.*}
  echo $volumeint
  if [ "$volumeint" -ge "$thresh" ] ; then
    cd /home/pi/majnun
# use raspberrypi camera to take a picture
    raspistill -e png -o "$(date +%s)".png
    sleep 10
# upload picture to dropbox
  fi
done
