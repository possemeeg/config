function document_set_base_dir {
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

function dls {
    document_set_base_dir $1

    count=1
    for f in $base_dir/*
    do
        name=$(basename $f)
        parent=$(basename $base_dir)
        ([ "$parent" != "Documents" ] && echo "$(printf "%2d" $count) $parent/$name") || echo "$name"
        ((count++))
    done
}

function dcd {
    AREA=""
    NAME=""
    [[ "$1" =~ ^([^/]+)/{0,1}(.*)$ ]] && AREA="${BASH_REMATCH[1]}" && NAME="${BASH_REMATCH[2]}"

    if [ "$NAME" == "" ]
    then
        dls $AREA
    fi

    document_set_base_dir $AREA

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

    cd "$base_dir"
    return 0

}

function gitwhichmod {
    IFS=$'\n'
    for subdir in $(find . -type d -maxdepth 1) 
    do
        if [ -d "$subdir/.git" ]
        then
            pushd $subdir > /dev/null
            TEST_OUT=$(git status -s)
            if [ "$TEST_OUT" != "" ]
            then
                echo "==== $subdir ===="
                echo "$TEST_OUT"
            fi
            popd > /dev/null
        fi
    done
}

