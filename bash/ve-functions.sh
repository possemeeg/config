# set up aliases for all venvs
for f in $(ls ~/Development/venv/)
do
    eval 'alias ve-$f=". ~/Development/venv/$f/bin/activate"'
done
# function to create a new venv
function ve-create {
   echo "$1 $2"
   if [ "$1" == "" ]
   then
      NAME=$(basename $(pwd))
   else
      NAME=$1
   fi
   if [ "$2" != "" ]
   then
      VER="$2"
   else
       echo "Require version"
       return
   fi
   pushd ~/Development/venv
   rm -r $NAME > /dev/null 2>1
   python${VER} -m venv $NAME
   popd
   alias ve-$NAME=".  ~/Development/venv/$NAME/bin/activate"
   .  ~/Development/venv/$NAME/bin/activate
   pip install -U pip
}
# function to delete a venv
function ve-delete {
   if [ "$1" == "" ]
   then
      NAME=$(basename $(pwd))
   else
      NAME=$1
   fi
   rm -r ~/Development/venv/$1
   unalias ve-$1
}

function ve {
   eval ve-$(basename $(pwd))
}
