#!/bin/bash

## set script variables
  now="$(date)"
  fileserver=/media/fileserver
  backup1=/media/backup-3TB-usb-seagate/backup
  backup2=/media/backup-2TB-usb-wd/backup

### inform user about the logging
  echo ''
  echo '## Backup script for fileserver'
  echo '## The logs for this script are saved in a file called backuplog.log in the Backup folder of each USB drive'
  echo "## e.g. $backup1/backuplog.log"

# mount the backup drives
  echo ''
  echo 'mounting backup drives'
  mount -a

## check backup drives are mounted
  if [ ! -d "$backup1/" ]; then
    echo 'unable to mount backup drive 3TB-usb-seagate'
    exit $?
  fi

  if [ ! -d "$backup2/" ]; then
    echo 'unable to mount backup drive 2TB-usb-seagate'
    exit $?
  fi

  echo 'Backup drives successfully mounted!'

## backup media files to Samsung 3TB USB drive
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

## backup other user files to Western Digital 2TB USB drive and remove deleted files from target
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
  umount /media/backup-3TB-usb-seagate -l
  umount /media/backup-2TB-usb-wd -l
  
  echo 'Done!'
