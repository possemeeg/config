
function gitpr {
    REMOTE="$(git config --get remote.origin.url)"
    REMOTE_URL="$(echo ${REMOTE} | sed -n 's/[^@]*@\([^:]*\):\(.*\)\.git/\1\/\2/p')"
    if [ "$REMOTE_URL" == "" ]
    then
        REMOTE_URL="$(echo ${REMOTE} | sed -n 's/ssh:\/\/[^@]*@\(.*\)\.git/\1/p')"
    fi
    PR_URL="https://${REMOTE_URL}/compare/$(git rev-parse --abbrev-ref HEAD)"

    echo "Remote: $REMOTE"
    echo "Remote URL: $REMOTE_URL"
    echo "PR URL: $PR_URL"
    open "$PR_URL"
}
