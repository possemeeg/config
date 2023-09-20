function document_set_base_dir {
    if [ "$1" == "1" ]
    then
        base_dir="1-projects"
    elif [ "$1" == "2" ]
    then
        base_dir="2-areas"
    elif [ "$1" == "3" ]
    then
        base_dir="3-resources"
    elif [ "$1" == "4" ]
    then
        base_dir="4-archive"
    else
        #echo "Need base area (1, 2, 3 or 4)."
        base_dir=
        return 0
    fi
    base_dir=~/Documents/$base_dir
}

function dls {
    document_set_base_dir $1
    if [ "$base_dir" == "" ]
    then
        for dir in 1 2 3 4
        do
            document_set_base_dir $dir
            echo "--- $(printf "%d" $dir) $base_dir ---"
            dls $dir
        done
        return 0
    fi

    count=1
    for f in $base_dir/*
    do
        name=$(basename $f)
        parent=$(basename $base_dir)
        echo "$(printf "%2d" $count) $parent/$name"
        ((count++))
    done
}

function dcd {
    if [ "$2" == "" ]
    then
        dls $1
    fi

    document_set_base_dir $1
    if [ "$base_dir" == "" ]
    then
        echo "Need base area (1, 2, 3 or 4). And dir or index."
        return 1
    fi

    param=$2

    re='^[0-9]+$'
    if [[ $param =~ $re ]]
    then
        count=1
        for f in $base_dir/*
        do
            if [[ $count == $param ]]
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

