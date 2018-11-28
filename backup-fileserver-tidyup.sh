#!/bin/bash

## !! this is a variant of the script backup-fileserver.sh. This version automatically deletes files in the destination drive if it does not exist in the source. 
## !! this is to tidy up the backup drive of files that have been correctly deleted on the source drive. No not run this automatically as it will 
## !! DESTROY good backups if the source files are not available or deleted.  

## This script is for doing a simple backup of a number of directories to some backup drives
## the backup drives need to be listed in fstab to ensure they are mounted. This script runs 'mount -a' to ensure fstab entries are mounted.
## the paths of the backup drives should be entered in the variables $backup1, $backup2, etc. Two drives have been used in this example but more can be added or removed as required.
## the scripts uses rsync to backup the directories. The backup is updated each time the script is run. It does not keep previous versions
## The script unmounts the backup devices once the backups have completed. This is to protect agains automated ransomware attacks against mounted paths

## script variables
now="$(date)"
fileserver=/media/fileserver
backup1=/media/backup-2TB
backup2=/media/backup-3TB
backup3=/media/backup-4TB

### inform user about the logging
echo "\n## Backup script for fileserver"
echo '## The logs for this script are saved in a file called backuplog.log in the root of each USB drive'
echo "## e.g. $backup1/backuplog.log\n"

## check backup drive is mounted
for i in $backup2 $backup3
do
	if [ ! -e "$i/.mounted" ]; then
  		echo 'unable to mount backup drive' $i
  		exit $?
	fi
done
echo 'All backup drives successfully mounted!'

# do the backups to drive 1
#for i in 'books' 'comedy' 'drama'
#do
#	echo ' - Backing up' $i 'to' $backup1
#	echo 'Backing up' $i 'at' $now >> $backup1/backuplog.log
#	rsync $fileserver/$i/ $backup1/$i -rtv --delete >> $backup1/backuplog.log
#done	

# do the backups to drive 2
for i in 'scifi' 'music' 'users' 'software' 'documentary' 'books'
do
        echo ' - Backing up' $i 'to' $backup2
        echo 'Backing up' $i 'at' $now >> $backup2/backuplog.log
        rsync $fileserver/$i/ $backup2/$i -rtv --delete >> $backup2/backuplog.log
done

# do the backups to drive 3
for i in 'films' 'drama' 'comedy'
do
        echo ' - Backing up' $i 'to' $backup3
        echo 'Backing up' $i 'at' $now >> $backup3/backuplog.log
        rsync $fileserver/$i/ $backup3/$i -rtv --delete >> $backup3/backuplog.log
done

echo "\nFile backups completed!"
