#!/bin/bash
FSWEB=$(dpkg -l |grep fswebcam)
if [ -z "$FSWEB" ]; then
sudo apt-get install fswebcam
fi
SIZES=('176x144' '320x240' '352x288' '640x360' '640x480' '1280x720')
echo -n "Enter the number of photos: "; read -n 1 FRAMES
echo ""
echo "1. ${SIZES[0]}"
echo "2. ${SIZES[1]}"
echo "3. ${SIZES[2]}"
echo "4. ${SIZES[3]}"
echo "5. ${SIZES[4]}"
echo "6. ${SIZES[5]}"
echo -n "Select the resolution: " ; read -n 1 SELECT
echo ""
echo -n "Enter the delay between all photos (s): "; read -n 1 DELAY
echo ""
F=0
INDEX=$(($SELECT - 1))
RES=$(echo ${SIZES[$INDEX]})
while [[ $F < $FRAMES ]]; do
	F=$(($F + 1))
	IMAGE=Photos/"Jose-$(date +"%Y-%m-%d_%H:%M:%S").jpg"
	fswebcam -r $RES $IMAGE
	if [[ $DELAY > 0 ]]; then
	 sleep $DELAY
	fi
tar -czvf Photos.tar.gz Photos
done
