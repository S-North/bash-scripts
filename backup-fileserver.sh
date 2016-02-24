#!/bin/bash

## This script is for doing a simple backup of a number of directories to some backup drives
## the backup drives need to be listed in fstab to ensure they are mounted. This script runs 'mount -a' to ensure fstab entries are mounted.
## the paths of the backup drives should be entered in the variables $backup1, $backup2, etc. Two drives have been used in this example but more can be added or removed as required.
## the scripts uses rsync to backup the directories. The backup is updated each time the script is run. It does not keep previous versions
## The script unmounts the backup devices once the backups have completed. This is to protect agains automated ransomware attacks against mounted paths

## set script variables
  now="$(date)"
  fileserver=/media/fileserver                    # the root directory for all the user files to be backed up
  device1=/media/backup-3TB-usb-seagate           # backup device 1's mount point [3TB Samsung USB drive]
  device2=/media/backup-2TB-usb-wd                # backup device 2's mount point [2TB Western Digital USB drive]
  backup1=$device1/backup                         # path to the backup folder on device 1
  backup2=$device2/backup                         # path to the backup folder on device 2

### inform user about where the script logs its output
  echo ''
  echo '## Backup script for fileserver'
  echo '## The standard output for this script are saved in a file called backuplog.log in the Backup folder of each USB drive'
  echo "## e.g. $backup1/backuplog.log"
  echo 'error output will be logged to this console'

# mount the backup drives
  echo ''
  echo 'mounting backup drives'
  mount -a

## check backup drives are mounted. If they are not found, exit the script with a message and the error text.
  if [ ! -d "$backup1/" ]; then
    echo 'unable to mount backup drive 3TB-usb-seagate'
    exit $?
  fi

  if [ ! -d "$backup2/" ]; then
    echo 'unable to mount backup drive 2TB-usb-seagate'
    exit $?
  fi

## If the drives are found, tell the user and continue
  echo 'Backup drives successfully mounted!'

## backup media files to backup device 1
  echo '##########################################################' >> $backup1/backuplog.log
  echo "Backed up at $now" >> $backup1/backuplog.log
  echo '##########################################################' >> $backup1/backuplog.log
  
  echo 'Backing up books'
  echo 'Backing up books' >> $backup1/backuplog.log
  rsync $fileserver/books/ $backup1/books -vah >> $backup1/backuplog.log

  echo 'Backing up documentaries'
  echo '----------------------------------------------------------' >> $backup1/backuplog.log
  echo 'Backing up documentaries' >> $backup1/backuplog.log
  rsync $fileserver/documentary/ $backup1/documentary -vah >> $backup1/backuplog.log
  
  echo 'Backing up films'
  echo '----------------------------------------------------------' >> $backup1/backuplog.log
  echo 'Backing up films' >> $backup1/backuplog.log
  rsync $fileserver/films/ $backup1/films -vah >> $backup1/backuplog.log
  
  echo 'Backing up tv comedies'
  echo '----------------------------------------------------------' >> $backup1/backuplog.log
  echo 'Backing up comedies' >> $backup1/backuplog.log
  rsync $fileserver/comedy/ $backup1/comedy -vah >> $backup1/backuplog.log
  
  echo 'Backing up dramas'
  echo '----------------------------------------------------------' >> $backup1/backuplog.log
  echo 'Backing up dramas' >> $backup1/backuplog.log
  rsync $fileserver/drama/ $backup1/drama -vah >> $backup1/backuplog.log
  
  echo 'backing up music'
  echo '----------------------------------------------------------' >> $backup1/backuplog.log
  echo 'Backing up music' >> $backup1/backuplog.log
  rsync $fileserver/music/ $backup1/music -vah >> $backup1/backuplog.log
  
  echo 'Backing up scifi'
  echo '----------------------------------------------------------' >> $backup1/backuplog.log
  echo 'Backing up scifi' >> $backup1/backuplog.log
  rsync $fileserver/scifi/ $backup1/scifi -vah >> $backup1/backuplog.log

## backup other user files to backup device 2
  echo '##########################################################' >> $backup2/backuplog.log
  echo "Backed up at $now" >> $backup2/backuplog.log
  echo '##########################################################' >> $backup2/backuplog.log
  
  echo 'Backing up user files'
  echo 'Backing up user files' >> $backup2/backuplog.log
  rsync $fileserver/users/ $backup2/users -vah >> $backup2/backuplog.log
  
  echo 'Backing up software'
  echo '----------------------------------------------------------' >> $backup2/backuplog.log
  echo 'Backing up software' >> $backup2/backuplog.log
  rsync $fileserver/software/ $backup2/software -vah >> $backup2/backuplog.log
  
  echo ''
  echo 'File backups completed!'
  
## unmount the backup drives
  echo ''
  echo 'Unmounting backup drives'
  umount $device1 -l
  umount $device2 -l
  
  echo 'Done!'
