#!/bin/bash

#
# See find-lots-of-file-dirs.sh to edit ~/Documents/.rclone-ignore

TEST_MODE=$1
if [ "$TEST_MODE" == "1" ]
then
    TEST_FILES_TO_CP=files-to-cp.txt
    TEST_EXCLUDED=excluded.txt
    echo "Test mode: creating files $TEST_FILES_TO_CP and $TEST_EXCLUDED"
else
    if [ "$RCLONE_BACKUP_REMOTE" == "" ]
    then
        echo "Must set RCLONE_BACKUP_REMOTE - do: rclone listremotes"
        exit 1
    fi
fi

HARD_EXCLUDE_FROM_FILE=~/Documents/.rclone-ignore
EXCLUDE_FROM_FILE="$(mktemp)"
CLONE_ROOT_DIR=~/Documents
REMOTE=antgdrive
MAX_FILE_SIZE=1G
MAX_DIR_SIZE=6G
MAX_NUM_FILES_IN_DIR=100

echo "Creating exclude file: $EXCLUDE_FROM_FILE"
echo "# exclude file" > $EXCLUDE_FROM_FILE

echo "# Excluding directies from $HARD_EXCLUDE_FROM_FILE" >> $EXCLUDE_FROM_FILE
tail -1 $EXCLUDE_FROM_FILE
cat $HARD_EXCLUDE_FROM_FILE >> $EXCLUDE_FROM_FILE

pushd $CLONE_ROOT_DIR > /dev/null

echo "# Excluding git directories" >> $EXCLUDE_FROM_FILE
tail -1 $EXCLUDE_FROM_FILE
find . -type d -name .git -exec  dirname {} \; | sed -e 's/$/\//' -e 's/^.//' >> $EXCLUDE_FROM_FILE

echo "# Excluding files larger than $MAX_FILE_SIZE" >> $EXCLUDE_FROM_FILE
tail -1 $EXCLUDE_FROM_FILE
find . -size +$MAX_FILE_SIZE | sed -e 's/^.//' >> $EXCLUDE_FROM_FILE
 
echo "# Excluding directories larger than $MAX_DIR_SIZE" >> $EXCLUDE_FROM_FILE
tail -1 $EXCLUDE_FROM_FILE
du -S -t $MAX_DIR_SIZE ./*/ | cut -d$'\t' -f2- | awk '{$1=$1};1' | sed -e 's/$/\//' -e 's/^.//' >> $EXCLUDE_FROM_FILE

echo "# Excluding directorys with more than $MAX_NUM_FILES_IN_DIR files" >> $EXCLUDE_FROM_FILE
tail -1 $EXCLUDE_FROM_FILE
IFS=$'\n' && for f in $(find . -type d |sort -u); do echo $(find "$f" -maxdepth 1 -name "*" |wc -l):$f; done | awk -v max_fs="$MAX_NUM_FILES_IN_DIR" -F: '{if($1>max_fs)print$2}' | sed -e 's/$/\//' -e 's/^.//' >> $EXCLUDE_FROM_FILE

if [ "$TEST_MODE" == "1" ]
then
    rclone ls . --skip-links --exclude-from=$EXCLUDE_FROM_FILE > $TEST_FILES_TO_CP
    cp $EXCLUDE_FROM_FILE $TEST_EXCLUDED
    echo "Test mode: created $TEST_FILES_TO_CP and $TEST_EXCLUDED"
else
    REMOTE_ROOT="backup/`hostname`"
    STATS_ROOT="$REMOTE_ROOT/`printf '%(%Y-%m-%d %H:%M:%S)T' -1`"
    echo "Syncing (what about?) to $RCLONE_BACKUP_REMOTE:$REMOTE_ROOT."
    rclone sync . $RCLONE_BACKUP_REMOTE:$REMOTE_ROOT/current/Document --progress --skip-links --exclude-from=$EXCLUDE_FROM_FILE --backup-dir $RCLONE_BACKUP_REMOTE:$REMOTE_ROOT/old/Document --log-file=$LOG_FILE --log-level INFO
    rclone copyto $EXCLUDE_FROM_FILE $RCLONE_BACKUP_REMOTE:$STATS_ROOT/excluded-from-backup.txt
    rclone copy $LOG_FILE $RCLONE_BACKUP_REMOTE:$STATS_ROOT
    rm $LOG_FILE
fi

rm $EXCLUDE_FROM_FILE

popd > /dev/null
