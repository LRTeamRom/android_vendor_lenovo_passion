#!/system/bin/sh

#Note:
#To clean up the specified data which lies in /persist/data/sfs with old information
#This action should be worked as a class main service and rely on some condition...
#

PROP_DEP=`getprop sys.listeners.registered`
#if [ $PROP_DEP == "" ];then
#	echo "qseecomd has not be prepared yet..."
#	exit
#fi


#Particularly, commands as below should be only excuted once when handling the action
#with flashing the whole eMMc or resetting /data/ partition
#PROP_CRYPT=`getprop ro.crypto.state`
#if [ "$PROP_CRYPT" == "encrypted" ];then
#	exit 0
#fi

#Deprecate the FDE scenario
PROP_VOLD_DECRYPT=`getprop vold.decrypt`
if [ "$PROP_VOLD_DECRYPT" != "" ];then
	exit 0
fi

if [ ! -e /data/persist_sfs ];then
	touch /data/persist_sfs/flag
	echo -e "[purge_sfs]:create a file as flag for judgment..." >>/data/persist_sfs/flag
	if [ -d /persist/data/sfs/ ];then
		if [ -e /data/persist_sfs/flag ];then
			/system/bin/rm -rf /persist/data/sfs/
		fi
		echo -e "[purge_sfs]:remove the fingerprint data successfully..." >>/data/persist_sfs/flag
	fi
fi

#Start vfmservice for FingerPrint enrolling for each time in boot up stage
#It's awful for FDE scenario and vfmService would not go here at anytime
#setprop sys.listeners.fp true

