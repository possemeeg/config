# set up aliases for all venvs

mkdir -p ~/.config/ve

function ve-list {
    for f in ~/.config/ve/*
    do
        name=$(basename $f)
        echo "${name}: $(cat $f)/${name}/bin/activate"
    done
}

function ve-create {
   if [ "$1" != "" ]
   then
      NAME=$1
   else
      echo "Require name version"
      return 1
   fi
   if [ "$2" != "" ]
   then
      VER="$2"
   else
      echo "Require python version"
      return 1
   fi
   if [ "$3" != "" ]
   then
      VENV_ROOT="$(realpath $3)"
   else
      VENV_ROOT="/home/peter/Development/venv"
   fi

   if [ -d "$VENV_ROOT/${NAME}" ]
   then
       echo "Directory $VENV_ROOT/${NAME} exists. Delete or call ve-delete $NAME"
       read -p "Envoke 've-delete $NAME' now and continue?: (y/N) " yn
       case $yn in
           [Yy]* ) ve-delete $NAME;;
           * ) return 1;;
       esac
   fi

   CONFIG_FILE="/home/peter/.config/ve/${NAME}"
   echo "config file: $CONFIG_FILE"

   if [ -f "$CONFIG_FILE" ]
   then
       echo "File $CONFIG_FILE exists. Delete or call ve-delete $NAME"
       return 1
   fi

   echo "$NAME - $VER - $VENV_ROOT"
   mkdir -p "$VENV_ROOT"
   pushd "$VENV_ROOT"
   python${VER} -m venv $NAME
   popd

   echo "$VENV_ROOT" > $CONFIG_FILE

   . ${VENV_ROOT}/${NAME}/bin/activate

   pip install -U pip

}

function ve-delete {
   if [ "$1" != "" ]
   then
      NAME=$1
   else
      echo "Require name of virtual environment"
      return
   fi
   config_file=~/.config/ve/${NAME}
   config_dir=$(cat $config_file)/${NAME}

   deactivate || echo "not in ve"

   read -p "Okay to remove directory ${config_dir} and file ${config_file}: (y/N) " yn
   case $yn in
       [Yy]* ) rm -r ${config_dir}; rm ${config_file};;
       * ) echo "Nothing deleted";;
   esac
}

function ve-go {
   if [ "$1" != "" ]
   then
      NAME=$1
   else
      echo "Require name version"
      return 1
   fi

   . $(cat ~/.config/ve/${NAME})/${NAME}/bin/activate
}

