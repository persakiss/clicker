#!/bin/bash

net=false

# Debug sleep, give time to term process
echo "Giving kill time in case of debug.."
sleep 15

echo "Checking internet..."
while [ "$net" = "false" ]
	do
		if ping -q -c 1 -W 1 google.com >/dev/null; then
			net=true
			echo "Internet good!"
		else
			echo "Internet down, resetting"
		
			echo "home" | sudo -S ifdown eth0
			sleep 10s

			echo "home" | sudo -S ifup eth0
			sleep 10s

			echo "Reset completed"
		fi
	done

if [ "$net" = "true" ]; then
	echo "Deleting old clicker"
	rm -f /home/home/clicker
	echo "Deleted old clicker"

	sleep 2s
	
	echo "Downloading new clicker"
	wget https://sickle.red/tools/clicker /home/home/clicker
	echo "Downloaded new clicker, setting permissions"	

	sleep 2s
	echo "home" | sudo -S chmod a+x /home/home/clicker
	
	sleep 2s
	echo "Executing clicker file"
	exec ~/clicker &
fi
