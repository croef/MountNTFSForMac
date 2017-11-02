#! /bin/bash

DISK=`diskutil list | grep NTFS | awk '{print $NF}'`
DISK_COUNT=`echo $DISK | wc -l`

if [ "$DISK_COUNT" -ne "1" ]
then
	echo "ntfs disk more than 1, is"
	echo $DISK
	exit 1
fi

UUID=`diskutil info $DISK | grep UUID | awk '{print $3}'`
if [ -z "$UUID" ]
then
  echo 'UUID is null'
  exit 1
fi

WRITE_STR='UUID='$UUID' none ntfs rw,auto,nobrowse'


echo '1. backup /etc/fstab to ~/Desktop/fstab.bak'
cp /etc/fstab ~/Desktop/fstab.bak

echo '2. disk is '$DISK', UUID is '$UUID', will write:'
echo ''
echo $WRITE_STR'\tto\t/etc/fstab'
echo ''
echo $WRITE_STR >> /etc/fstab
echo 'write done'
echo ''
echo '3. unmount and mount your ntfs device'
echo ''
echo '4. open /Volumes/ and you will find your device'
echo ''
echo '4.1 you might do ln -s /Volumes/your_device_name ~/Desktop/your_device_name'
