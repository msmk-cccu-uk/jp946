# jp946
In this project, it is proposed to create a monitoring system using a camera above the Ultimaker machines, which staff and students can use to check the progress of the print and to check that the part has been created as expected. This aims to reduce delays in project construction and reduce wastage of 3D printed material.

The hardware is a laptop computer, with an integrated camera.

The software is an Ubuntu virtual machine. In this virtual machine, we created a script, which requires the "fswebcam" program to be installed on the computer. If it is not installed, the script will install it automatically. The script is designed for Debian-based operating systems.


This is the scrpt:
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




The following are the steps in the script:

The first line indicates that the Bash interpreter is being used.

#!/bin/bash 

The next line checks if the fswebcam program is installed. To do this, the dpkg command is used to list all installed packages and the result is filtered with grep to search for the fswebcam package. If the variable $FSWEB is empty (i.e. if the package is not found), then it is installed with apt-get.

FSWEB=$(dpkg -l |grep fswebcam)
 if [ -z "$FSWEB" ]; then
 sudo apt-get install fswebcam
 fi 
 
A SIZES array is defined containing the different resolutions available to capture the photos.

SIZES=('176x144' '320x240' '352x288' '640x360' '640x480' '1280x720') 

The user is prompted to enter the number of photos to be captured.

echo -n "Enter the number of photos: "; read -n 1 FRAMES
echo "" 
 
The available resolution options, numbered from 1 to 6, are displayed on the screen.

echo "1. ${SIZES[0]}"
 echo "2. ${SIZES[1]}"
 echo "3. ${SIZES[2]}"
 echo "4. ${SIZES[3]}"
 echo "5. ${SIZES[4]}"
 echo "6. ${SIZES[5]}" 
 
The user is prompted to select one of the available resolutions by entering the corresponding number.

echo -n "Select the resolution: " ; read -n 1 SELECT
echo "" 

The user is prompted to enter the number of seconds to wait between capturing each photo.

echo -n "Enter the delay between all photos (s): "; read -n 1 DELAY 
echo "" 

Two variables, F and INDEX, are initialised and the RES variable is assigned the resolution selected by the user.

F=0
 INDEX=$(($SELECT - 1))
 RES=$(echo ${SIZES[$INDEX]}) 
 
A while loop is started and will repeat as long as F is less than FRAMES. Each iteration increments the variable F by 1, names the captured image with the current date and time, and uses the fswebcam command to capture the photo at the selected resolution. If a timeout between photos was specified, it waits for that time with the sleep command. Finally, all the photos are compressed into a file called Photos.tar.gz.

while [[ $F < $FRAMES ]]; do 
F=$(($F + 1)) 
IMAGE=Photos/"Jose-$(date +"%Y-%m-%d_%H:%M:%S").jpg"
 fswebcam -r $RES $IMAGE
if [[ $DELAY > 0 ]]; then
sleep $DELAY 
fi
 tar -czvf Photos.tar.gz Photos
 done

Thanks to this script, it will be possible to monitor printouts through photos.

