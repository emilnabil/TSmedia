#!/bin/sh
##
##setup command=wget http://tunisia-dreambox.info/TSmedia/software_official/installer.sh -O - | /bin/sh
#lock=mkmlw12345
#software_updates=Youtube TV and many more......\nbest enjoyment\n TSmedia Team
#builddate=15-04-2021
#needsstart=False
#last_update=f290520202_17.2_update
version=17.2
######
LINE='----------------------------------------------------'

BRANATV=/usr/lib/enigma2/python/boxbranding.so ## OpenATV
BRANDPLI=/usr/share/enigma2/hw_info/hw_info.cfg ## OpenPLI
BRANDOPEN=/usr/lib/enigma2/python/Tools/StbHardware.pyo ## Open source
BRANDOS=/var/lib/dpkg/status ## DreamOS
BRANDVU=/proc/stb/info/vumodel ## VU+
VTI=/usr/lib/enigma2/python/Plugins/SystemPlugins/VTIPanel ## VTI
BLACKHOLE=/usr/lib/enigma2/python/Blackhole ## BH VU+

if grep -qs -i "openpli" /etc/issue; then
   IMAGE=openpli
fi

# Test Free space command order
FREENEEDTS=13
FREENEEDEXPLAYER=5

# Find Arch of device
CHECK='/tmp/check'
echo
echo $LINE
uname -m > $CHECK
sleep 1;
if grep -qs -i 'mips' cat $CHECK ; then
	echo "[ Your device is MIPS ]"
	DEVICE=mips
elif grep -qs -i 'armv7l' cat $CHECK ; then
	echo "[ Your device is armv7l ]"
	DEVICE=armv7l
elif grep -qs -i 'aarch64' cat $CHECK ; then
	echo "[ Your device is aarch64 ]"
	DEVICE=aarch64
else
	echo 'Sorry, your Device Not supported Yet ..'
fi
	echo $LINE
echo "Checking for an older version of TSmedia in the system..."
if [ -d /usr/lib/enigma2/python/Plugins/Extensions/TSmedia ]; then
  echo "An older version of TSmedia was found"
 
echo "removing older version...installed addons will not be removed"
           
           rm -r /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/addons/youtube/youtube/youtubeAPI.pyo
           rm -r /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/addons/youtube/youtube/default.pyo
           
           rm -r /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/screens >/dev/null 2>&1

	rm -r /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/interface >/dev/null 2>&1

	rm -r /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/scripts >/dev/null 2>&1

        rm -r /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/updates >/dev/null 2>&1

	rm -r /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/lib >/dev/null 2>&1

	rm -f /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/plugin.py >/dev/null 2>&1

	rm -f /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/startmenu.py >/dev/null 2>&1

	rm -f /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/configs.py >/dev/null 2>&1

	rm -f /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/bootlogo.py >/dev/null 2>&1

	rm -f /usr/lib/enigma2/python/Plugins/Extensions/TSmedia/version >/dev/null 2>&1
  echo "Checking free space..."
  USED=`du -s /usr/lib/enigma2/python/Plugins/Extensions/TSmedia | cut -f1`

  FREE=`df  -Pk /usr | tr -s ' ' | cut -d' ' -f4 | tail -n1`
FREEU=`df -h -Pk /usr | tr -s ' ' | cut -d' ' -f4 | tail -n1`


  echo "your box free space $FREEU"
  NEED=$(($USED + $FREE))
  if [[ $NEED -lt 16000 ]]; then
    echo "Less than 16MB free space left on the root filesystem, installation aborted."
  else
    echo "Proceeding to installation..."
    
  fi
else
  echo "TSmedia was not found in the system"
  echo "Checking free space..."
  FREE=`df h -Pk /usr | tr -s ' ' | cut -d' ' -f4 | tail -n1`
FREEU=`df -h -Pk /usr | tr -s ' ' | cut -d' ' -f4 | tail -n1`


  echo "your box free space $FREEU"
  if [[ $FREE -lt 16000 ]]; then
    echo "Less than 16MB free space left on the root filesystem, installation aborted."
  else
    echo "Proceeding to installation..."

   
  fi
fi
# Download and install plugin
	echo "[ Download and install plugin ]"
	echo $LINE
	cd /tmp 
	if [ -f /tmp/tsmedia.tar.gz ]; then 
   		rm -f tsmedia.tar.gz >/dev/null 2>&1
	fi
	wget  "https://github.com/emil237/plugins/raw/main/tsmedia.tar.gz" 
	tar -xzf tsmedia.tar.gz -C / >/dev/null 2>&1

# install libtorrent
	echo $LINE
	echo "[ Installing libtorrent ]"
	echo ""
	if [ -f $BRANDOS ]; then 
		echo "[ Sorry libtorrent is not availabe for DreamOS images ]"
	elif [ -f $BRANDVU -a -f $VTI -o -f $BLACKHOLE ]; then
		echo "[ Sorry libtorrent is not availabe for BH/VTI VU+ images ]"
	#elif [ $DEVICE = "armv7l" -a -f $BRANDPLI -a $IMAGE = "openpli" ]; then 
		#echo "[ Sorry libtorrent is not availabe for OpenPLI ARM images ]"
	else
		echo "[ Your Device not supported (Ask US about it)... ]"
	fi
# install Finished install TSmedia
	echo $LINE
	rm -f tsmedia.tar.gz >/dev/null 2>&1 then
	cd ..
	sync

# install exteplayer3
if [[ $FREE -lt $FREENEEDEXPLAYER ]]; then
	echo $LINE
	echo "[ No free space in device to install exteplayer3 .. Need at lest $FREENEEDEXPLAYER MB free Space ]"
	echo $LINE
	echo "#############################################################"
	echo "#          TSmedia installed successfully                   #"
	echo "#                     TSmedia Team                          #"              
	echo "#                       support                             #"
	echo "#         arabic support  https://www.tunisia-sat.com/      #"
	echo "#         English,French support  https://www.yassinov.com/ #"
	echo "#############################################################"
	echo "#               restarting your receiver                    #" 
	echo "#############################################################"
	killall -9 enigma2
else
	echo $LINE
	echo "[ Try to Installing exteplayer3 if the feed have it.... ]"
	echo $LINE
	opkg update
	opkg install exteplayer3
           opkg install python-requests

	echo "#############################################################"
	echo "#          TSmedia installed successfully                   #"
	echo "#                     TSmedia Team                          #"              
	echo "#                       support                             #"
	echo "#         arabic support  https://www.tunisia-sat.com/      #"
	echo "#         English,French support  https://www.yassinov.com/ #"
echo "#    support Script By Emil Nabil  #"
sleep 4;
	echo "#############################################################"
	echo "#               restarting your receiver                    #" 
	echo "#############################################################"
	#killall -9 enigma2
fi

rm -f /tmp/check*
exit 0








