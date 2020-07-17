#history -r ~/.glob_history

export GPG_TTY=$(tty)
#export ANSIBLE_VAULT_PASSWORD_FILE=${HOME}/dice/infra/black-hole/ansible-vault
export ANSIBLE_VAULTS="--vault-id ${HOME}/dice/infra/black-hole/.streaming_vault_pass --vault-id ${HOME}/dice/infra/black-hole/.dce-vault-pass"
export PROMPT_COMMAND="history -a ~/.glob_history > /dev/null"

. ~/.aws/no-env.sh

alias ll="ls -l"
alias awswhich="~/dice/infra/pmsb/script/awswhich.sh"
alias awstags="~/dice/infra/pmsb/script/awstags.sh"
alias awsssh="~/dice/infra/pmsb/script/awsssh.sh"
alias awsto="~/.aws/to.sh"
alias tmpname='~/dice/infra/pmsb/script/tmpname.sh'
alias ag='ag --case-sensitive'
alias auth='~/dice/infra/pmsb/script/auth.sh'
alias vlc='/Applications//VLC.app/Contents/MacOS/VLC --intf rc'
alias ghist='cat ~/.glob_history |sort -u |ag'
alias javafmt='/Applications/IntelliJ\ IDEA.app/Contents/bin/format.sh'
#alias javafmt='java -jar ~/dice/infra/pmsb/code/google-java-format-1.7-all-deps.jar --replace'
alias java8="export JAVA_HOME=$(/usr/libexec/java_home -v 1.8); java -version"
alias java11="export JAVA_HOME=$(/usr/libexec/java_home); java -version"

eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa
