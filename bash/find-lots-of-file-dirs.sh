
IFS=$'\n' && for f in $(find . -type d |sort -u); do echo $(find "$f" -maxdepth 1 -name "*" |wc -l):$f; done | awk -v max_fs="$MAX_NUM_FILES_IN_DIR" -F: '{if($1>max_fs)print$2}' | sed -e 's/$/\//' -e 's/^.//'


do echo $(find "$f" -maxdepth 1 -name "*" |wc -l) $(realpath $f); done |sort -rn | head -40
