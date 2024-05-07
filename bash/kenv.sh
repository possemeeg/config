#
kenv() {
    local clean_ps1 ps1_upd=""
    if [ "$1" != "" ]
    then
        local cluster region project ps1_upd
        if [ "$1" == "prod" ]
        then
            cluster=production-cluster
            region=europe-west1-c
            project=antidote-production
            ps1_upd="<K8s: \[\033[1;31m\]PRODUCTION\[\033[0m\]> "
        elif [ "$1" == "stag" ]
        then
            cluster=staging-cluster
            region=europe-west1-c
            project=antidote-infrastructure
            ps1_upd="<K8s: \[\033[1;31m\]STAGING\[\033[0m\]> "
        elif [ "$1" == "build" ]
        then
            cluster=build
            region=europe-west1-d
            project=antidote-infrastructure
            ps1_upd="<K8s: \[\033[1;35m\]BUILD\[\033[0m\]> "
        else
            echo "invalid env"
            return
        fi
        #bash --rcfile <(echo ". ~/.bashrc; export KUBECONFIG=$kubeconfig; export PS1=\"\[\033[1;31m\][K8s env: $1]\[\033[0m\] ${PS1:-}\"; export TMOUT=300; $credcmd")

        export KUBECONFIG=$(mktemp)
        gcloud container clusters get-credentials $cluster --region=$region --project=$project
    else
        if [ "$KUBECONFIG" != "" ]
        then
            rm $KUBECONFIG
            unset KUBECONFIG
        fi
    fi
    clean_ps1=$(echo "${PS1:-}" | sed 's/<K8s:[^>]*> //g')
    export PS1="${ps1_upd}${clean_ps1}"
}
