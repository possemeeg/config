#!/bin/bash

#
# See find-lots-of-file-dirs.sh to edit ~/Documents/.rclone-ignore

HARD_EXCLUDE_FROM_FILE=~/Documents/.rclone-ignore
cat $HARD_EXCLUDE_FROM_FILE
EXCLUDE_FROM_FILE="/tmp/rclone-excludes.txt"
CLONE_ROOT_DIR=~/Documents
REMOTE=antgdrive

pushd $CLONE_ROOT_DIR
find . -type d -name .git -exec  dirname {} \; | sed -e 's/$/\//' -e 's/^.//' > $EXCLUDE_FROM_FILE

cat $HARD_EXCLUDE_FROM_FILE >> $EXCLUDE_FROM_FILE

rclone sync . $REMOTE:backup/current/Document --progress --skip-links --exclude-from=$EXCLUDE_FROM_FILE --backup-dir $REMOTE:backup/old/Document
#rclone ls . --skip-links --exclude-from=$EXCLUDE_FROM_FILE

popd
