esenv() {
    local clean_ps1 ps1_upd=""
    if [ "$1" != "" ]
    then
        if [ "$1" == "prod" ]
        then
            export ES_HOST=https://antidote-production.es.europe-west1.gcp.cloud.es.io
            export ES_PASSWORD=$(op item get --fields 'label=prod-elastic-password'  $(op item list |ag 'Elasticsearch passwords' |cut -d' ' -f1))
            ps1_upd="<ES: \[\033[1;31m\]PRODUCTION\[\033[0m\]> "
        elif [ "$1" == "stag" ]
        then
            export ES_HOST=https://antidote-staging.es.europe-west1.gcp.cloud.es.io
            export ES_PASSWORD=$(op item get --fields 'label=stag-elastic-password'  $(op item list |ag 'Elasticsearch passwords' |cut -d' ' -f1))
            ps1_upd="<ES: \[\033[1;31m\]STAGING\[\033[0m\]> "
        else
            echo "invalid env"
            return
        fi

        export ES_SCHEME=https
        export ES_USERNAME=elastic
        export ES_PORT=443
        export ES_LOCAL_HOST="$ES_HOST"
        export ES_LOCAL_PORT="$ES_PORT"
        export ELASTIC_USER="$ES_USERNAME"
        export ELASTIC_PASSWORD="$ES_PASSWORD"
        export BUILDBOT_STAGING_ES_PORT=443
        export BUILDBOT_STAGING_ES_HOST=antidote-staging.es.europe-west1.gcp.cloud.es.io
        export BUILDBOT_STAGING_ES_USERNAME=buildbot
        export BUILDBOT_PRODUCTION_ES_PORT=443
        export BUILDBOT_PRODUCTION_ES_HOST=antidote-production.es.europe-west1.gcp.cloud.es.io
        export BUILDBOT_PRODUCTION_ES_USERNAME=buildbot
        export BUILDBOT_STAGING_ES_CLOUD_PASSWORD=$(op item get --fields 'label=stag-buildbot-password'  $(op item list |ag 'Elasticsearch passwords' |cut -d' ' -f1))
        export BUILDBOT_PRODUCTION_ES_CLOUD_PASSWORD=$(op item get --fields 'label=prod-buildbot-password'  $(op item list |ag 'Elasticsearch passwords' |cut -d' ' -f1))
    else
        unset ES_HOST
        unset ES_PASSWORD
        unset ES_SCHEME
        unset ES_USERNAME
        unset ES_PORT
        unset ES_LOCAL_HOST
        unset ES_LOCAL_PORT
        unset ELASTIC_USER
        unset ELASTIC_PASSWORD
        unset BUILDBOT_STAGING_ES_PORT
        unset BUILDBOT_STAGING_ES_HOST
        unset BUILDBOT_STAGING_ES_USERNAME
        unset BUILDBOT_PRODUCTION_ES_PORT
        unset BUILDBOT_PRODUCTION_ES_HOST
        unset BUILDBOT_PRODUCTION_ES_USERNAME
        unset BUILDBOT_STAGING_ES_CLOUD_PASSWORD
        unset BUILDBOT_PRODUCTION_ES_CLOUD_PASSWORD
    fi
    clean_ps1=$(echo "${PS1:-}" | sed 's/<ES:[^>]*> //g')
    export PS1="${ps1_upd}${clean_ps1}"
}
