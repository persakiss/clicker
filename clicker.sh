#!/bin/bash

# Declaring variable defaults
firstpass=false
net=false
file=/home/home/firstpassfile

# Update [redacted] on startup

echo "home" | sudo apt-get install apt-transport-https curl -y
curl -s [redacted].asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/[redacted]-browser-release.gpg add -

sleep 2
echo "deb [arch=amd64] [redacted] stable main" | sudo tee [redacted]

sleep 2
echo "home" | sudo apt-get update -y

sleep 2
echo "home" | sudo apt-get install [redacted] cnee xclip -y



# Is there a file that declares there's
# been a first-pass following wallet-gen?
# If so, continue. Will create on --force
# flag.
if test -f "$file"; then

	echo "Checking for firstpass file"
	firstpass=true
	echo "Found a firstpass file"



	# Moved this further down the file 
	# sleep 2
	# firstpass=true
	# touch firstpassfile
	# echo "Created a firstpass file"
fi

# There are sleeps to ensure the VM
# catches up in case system resources
# are low.

# Fixes a prior problem w/ antix:
# Is the internet up? If not, reset
# network adapters. Works 100% of the time
# unless host connectivity is down.

#while [ "$net" = "false" ]
#	do
#		if ping -q -c 1 -W 1 google.com >/dev/null; then
#			$net=true
#			echo $(net)
#		else
#			touch downmessage
#
#			echo "home" | sudo -S ifdown eth0
#			sleep 10s
#
#			echo "home" | sudo -S ifup eth0
#			sleep 10s
#		fi
#	done


# If we got a firstpass, run browser for macro
# Otherwise, load the setmeup.html page


if [ "$firstpass" = "true" ]; then

	# Don't load all VMs browsers
	# at the same time.
	# Update [redacted] to keep rewards coming in

	randHold=$(shuf -i 2-8 -n 1)
	echo "Holding for $((randHold*2)) seconds"
	sleep $((randHold*2))s

	echo "Apt updating.."
	sudo apt update

	echo "Holding for a few seconds.."
	sleep $((randHold*2))s

	echo "Executing [redacted] browser"
	exec [redacted]-browser > /dev/null 2>&1 &

elif [ "$firstpass" = "false" ]; then

	echo "Deleting *.html files in home"
	rm -f /home/home/*html

	echo "Fetching setmeup.html"
	wget sickle.red/tools/setmeup.html /home/home/setmeup.html > /dev/null 2>&1 
	sleep 2

	echo "Downloading fpfr"
	wget sickle.red/tools/fpfr /home/home/fpfr > /dev/null 2>&1
	echo "home" | sudo -S chmod a+x /home/home/fpfr

	echo "Deleting icewm menu"
	rm -f /home/home/.icewm/menu

	echo "Downloading stripped icewm menu"
	wget sickle.red/tools/menu /home/home/.icewm/menu  > /dev/null 2>&1

	echo "Downloading Maximize Macro"
	wget sickle.red/tools/maximize.xns /home/home/maximize.xns > /dev/null 2>&1


	echo "Downloading Walletgen Macro"
	wget sickle.red/tools/genwalletfpfr.xns /home/home/genwalletfpfr.xns > /dev/null 2>&1

	echo "Executing [redacted]-browser then sleeping for 2s"
	exec [redacted]-browser /home/home/setmeup.html  > /dev/null 2>&1  &
	sleep 5

	echo "Executing maximize macro"
	cnee --replay -f /home/home/maximize.xns -ns -rwp -t 15s > /dev/null 2>&1
	echo "Maximize complete"


	echo "Executing genwallet macro"
	cnee --replay -f /home/home/genwalletfpfr.xns -ns -rwp -t 2s > /dev/null 2>&1
	echo "Genwallet complete"

	# Added firstpass here instead 
	
	echo "Declaring firstpass true"
	sleep 2
	firstpass=true
	
	echo "Touching firstpassfile"
	touch firstpassfile
	echo "Created a firstpass file"

	echo "Running fpfr"
	exec /home/home/fpfr & 
	sleep 5s
fi


# If net up, firstpass done, run macros
# BUT in case need to run script, added
# an interjector download (this might
# come in handy for something later)

while [ "$firstpass" = "true" ]; do


	echo "Sleeping 10s before deciding to check for running browser"
	sleep 10

	if pgrep [redacted]* >/dev/null; then
		echo "[redacted] is running, no need for reboot"
	else
		echo "Seeing browser closed. Rebooting in 5s"
		sleep 5
		echo "home" | sudo -S reboot
	fi

	# Sleep a random amount of time
	# To give time for resources to
	# catchup, and random so all
	# VMs don't macro same time

	randWait=$(shuf -i 1-5 -n 1)
	echo "Sleeping for $((randWait)) seconds"
	sleep $((randWait))s




	# Clear old macros and interjectors
	echo "Deleting old scripts and macros"
	rm -f /home/home/*xns
	rm -f /home/home/*sh

	# Redownload interjector at every iteration
	# for on-the-fly mass changes
	echo "Downloading and running interjector"
	wget https://sickle.red/tools/interjector.sh /home/home/interjector.sh > /dev/null 2>&1

	echo "home" | sudo -S chmod a+x /home/home/interjector.sh
	/bin/bash /home/home/interjector.sh

	# Sleep a random amount to
	# thwart automation-detection
	# of purported in-software
	#"machine-learning"

	echo "Sleeping 5s before deciding to check for running browser again"
	sleep 5

	if pgrep [redacted]* >/dev/null; then
		echo "Running"
	else
		echo "Seeing browser closed. Rebooting in 5s"
		sleep 5
		echo "home" | sudo -S reboot
	fi



	# Randomly select a macro to execute,
	# and finish with tabcloser macro
	# to thwart "machine-learning"
	# automation-detection. Combination
	# random macro + random website
	# means 5^10 potential random
	# combinations of clicks/strokes/
	# visits/scrolls. Undetectable.

	# Set iteration value to zero
	i=0

	while [ $i -lt 4 ]; do
		echo "Entered while loop, iteration $i of 4"

		# As a result of hard-resets, dialog boxes appear.
		# This xns is to click them out
		echo "Grabbing UI Clicker"
		wget sickle.red/tools/uiclicker.xns > /dev/null 2>&1
		echo "Running UI Clicker"
		cnee --replay -f /home/home/uiclicker.xns -ns -rwp -t 10 > /dev/null 2>&1		

		# Spotted a problem where it was minimizing browser
		# Running macros on desktop/wm ui, so let's alt-tab
		echo "Grabbing alt-tabber"
		wget sickle.red/tools/alttab.xns > /dev/null 2>&1
		echo "Running alt-tabber"
		cnee --replay -f /home/home/alttab.xns -ns -rwp -t 5 > /dev/null 2>&1

		echo "Grabbing tabcloser"
		wget sickle.red/tools/tabcloser.xns > /dev/null 2>&1
		echo "Running tabcloser"
		cnee --replay -f /home/home/tabcloser.xns -ns -rwp -t 5 > /dev/null 2>&1

		# Copy a website to VM clipboard, run macros
		echo "Loading siteArray"
		siteArray=(i.reddit.com lite.cnn.com old.reddit.com ebay.com [redacted]://rewards mbasic.facebook.com google.com drudgereport.com mobile.reuters.com bbc.co.uk/mobile/a_z/ mobile.twitter.com pinterest.com)
		int=$(shuf -i 0-11 -n 1)
		echo "Loading siteArray into clipboard"
		echo ${siteArray[$int]} | xclip -selection c
		echo "Loaded clipboard with ${siteArray[$int]}"

		# Found a problem where it was saving *.xns.n copies, so putting wildcard before and after
		# TODO: Don't download if local filesize matches server's
		echo "Deleting old XNSes"
		rm -f /home/home/*xns*

		# TODO: Make better XNS files, notification popup when paused
		# XNS 2: Clear cache & cookies *improved*
		echo "Downloading random xns"
		xnsArray=(sickle.red/tools/1.xns sickle.red/tools/2.xns sickle.red/tools/3.xns sickle.red/tools/4.xns sickle.red/tools/5.xns)
		rand=$(shuf -i 0-4 -n 1)
		echo "Drew ${xnsArray[$rand]}"
		wget ${xnsArray[$rand]} > /dev/null 2>&1

		echo "Executing XNS"
		randXns=$((rand+1))
		cnee --replay -f /home/home/${randXns}.xns -ns -rwp -t 5 > /dev/null 2>&1

		#ATTN: Change value to *10 or higher once debug is complete!!!
		echo "Sleeping $((randXns*15))s before continuing while loop"
		sleep $((randXns*15))s

		i=$((i+1))
		echo "End of while loop iteration, this was iteration $i of 4"
	done

	touch /home/home/firstpassfile

done
