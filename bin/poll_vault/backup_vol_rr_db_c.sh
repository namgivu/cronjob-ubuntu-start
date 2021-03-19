#!/bin/bash
set -aux
BACKUP_FROM_C=rr_db_c

SH=$(cd `dirname $BASH_SOURCE` && pwd)
log_f="$SH/.backup/log"

[ -z $BACKUP_FROM_C ] && (echo 'Envvar BACKUP_FROM_C is required' ; kill $$)  # name container's volume you want backup

TIME=`date +%Y%m%d_%H%M%S`
FILE_TAR="backup-$TIME.tar"
    DEFAULT_POSGRES_DATA_DIR='/var/lib/postgresql/data/'  # postgres ctn will have its data stored here <-- we create backup .tar file from this path
    BACKUP_TO_DIR="$SH/.backup"
    BACKUP_MIDDLEMAN_C='backup_middleman'

    #TODO review do we need -it?
    docker run -dit \
        --name $BACKUP_MIDDLEMAN_C      `# we use a :ubuntu ctn to tar folder :DEFAULT_POSGRES_DATA_DIR in ctn :BACKUP_FROM_C ` \
        --volumes-from $BACKUP_FROM_C   `# apply volume in ctn :BACKUP_FROM_C into this :backup_middleman ctn ie it will have postgres data mounted at @backup_middleman:$DEFAULT_POSGRES_DATA_DIR` \
        -v "$BACKUP_TO_DIR:/backup:rw"  `# backup file to be stored here` \
        ubuntu

        # do backup
        #TODO review do we need -i?
        docker exec -i $BACKUP_MIDDLEMAN_C /bin/bash -c "cd $DEFAULT_POSGRES_DATA_DIR && tar cvf /backup/$FILE_TAR ." >> $log_f

        docker rm -f $BACKUP_MIDDLEMAN_C  > /dev/null 2>&1 # clean up

    # backup aftermath check
    backup_f="$BACKUP_TO_DIR/$FILE_TAR"
    [ ! -f "$backup_f" ] && (echo "Backup file not found at $backup_f"; kill $$)
        echo -e "\n--- backup done \n$(ls -lah $backup_f) \n$backup_f"
