function ison() {
    for d in $(xinput list | ag 'Prestigio.*pointer' |ag -o 'id=([^\s]+)' |ag -o '[0-9]+'); do
        if [ $(xinput list-props $d | ag 'Device Enabled' |ag -o ':.*' | ag -o [0-9]+) == '1' ]; then
            return 0
        fi
    done
    return 1
}
if test "$#" -ge 1 && test $1 == 'stat'; then
    if ison; then
        echo Mouse On
        exit 0
    else
        echo Mouse off
        exit 1
    fi
else
    if ison; then
        echo Turning mouse off
        ENABLE='disable'
    else
        echo Turning mouse on
        ENABLE='enable'
    fi
    for d in $(xinput list | ag 'Prestigio.*pointer' |ag -o 'id=([^\s]+)' |ag -o '[0-9]+'); do
        xinput $ENABLE $d;
    done
fi
