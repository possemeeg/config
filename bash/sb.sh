_sb_document_set_base_dir() {
    base_dir=""
    search_string=""
    for area in 1-projects 2-areas 3-resources 4-archive
    do
        search_string=$search_string/$area
        if [ "$base_dir" == "" ] && [ "$1" == "${area:0:1}" ]
        then
            base_dir=$area
        fi
    done
    if [ "$base_dir" == "" ]
    then
        if [[ "$search_string" =~ (/|^)$1(/|$) ]]
        then
            base_dir="$1"
        fi
    fi
    base_dir=~/Documents/$base_dir
}

_sb_dls() {
    _sb_document_set_base_dir $1

    count=1
    for f in $base_dir/*
    do
        name=$(basename $f)
        parent=$(basename $base_dir)
        ([ "$parent" != "Documents" ] && echo "$(printf "%2d" $count) $parent/$name") || echo "$name"
        ((count++))
    done
}

_sb_dcd_area_name() {
    _dcd_area=""
    _dcd_name=""
    [[ "$1" =~ ^([^/]+)/{0,1}(.*)$ ]] && _dcd_area="${BASH_REMATCH[1]}" && _dcd_name="${BASH_REMATCH[2]}"
}


_sb_dcd() {
    AREA=""
    NAME=""
    [[ "$1" =~ ^([^/]+)/{0,1}(.*)$ ]] && AREA="${BASH_REMATCH[1]}" && NAME="${BASH_REMATCH[2]}"

    if [ "$NAME" == "" ]
    then
        cd "$base_dir"
        sb_dls $AREA
    fi

    _sb_document_set_base_dir $AREA

    if [[ $NAME =~ ^[0-9]+$ ]]
    then
        count=1
        for f in $base_dir/*
        do
            if [[ $count == $NAME ]]
            then
                cd "$f"
                return 0
            fi
            ((count++))
        done
        echo "Invalid index"
        return 1
    fi

    cd "$base_dir/$NAME"
    return 0

}

_sb_archive() {
    sb__dcd_area_name $1
    echo ": $_dcd_area/$_dcd_name"

    if [ "$_dcd_area" == "" ] || [ "$_dcd_name" == "" ] || [ "$_dcd_area" == "4" ]
    then
        echo "Invalid"
        return 1
    fi

    _sb_document_set_base_dir $AREA


    ##' WIP

}

_sb_completions() {
    if ! [[ "${#COMP_WORDS[@]}" =~ ^[2-3]$ ]]; then
      return
    fi
    local options=("ls" "cd" "ar")
    local optsions_str="${options[@]}"
    #local test="\<${COMP_WORDS[1]}\>"
    #if [[ ! ${options[@]} =~ $test ]]
    #then
    #    echo "Expect one of: ${options[@]}"
    #    return 1
    #fi
    local word1=${COMP_WORDS[1]}
    if [[ "${#word1}" =~ ^[0-1]$ ]]; then
      COMPREPLY=($(compgen -W "$optsions_str" "${word1}"))
      return
    fi

    if [ "${COMP_WORDS[2]}" == "" ]; then
      COMPREPLY=($(compgen -W "1-projects/ 2-areas/ 3-resources/ 4-archive/" ""))
      return
    fi

    if ! [[ ${COMP_WORDS[1]} =~ ^([^/]+)/.*$ ]]
    then
      COMPREPLY=($(compgen -W "1-projects/ 2-areas/ 3-resources/ 4-archive/" "${COMP_WORDS[1]}"))
      return
    fi

    local options
    options=""

    for dir in $(find ~/Documents/ -maxdepth 2 -mindepth 2 -path "*${COMP_WORDS[1]}*" -type d)
    do
        option="$(basename $(dirname $dir) )/$(basename $dir)"
        options+=" $option"
    done
    COMPREPLY=($(compgen -W "$options" "${COMP_WORDS[1]}"))
}

sb() {
    local options=("ls" "cd" "ar")
    local test="\<${1}\>"
    if [[ ! ${options[@]} =~ $test ]]
    then
        echo "Expect one of: ${options[@]}"
        return 1
    fi
    echo "Option $1"

}

complete -F _sb_completions -o nospace sb

