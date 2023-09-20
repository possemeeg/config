for f in $(find .  |xargs dirname |sort -u); do echo $(find "$f" -maxdepth 1 -name "*" |wc -l) $(realpath $f); done |sort -rn | head -40
