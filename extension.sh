export VIRTUAL_ENV_DISABLE_PROMPT=yes
VIRTUAL_ENV=""
venv_folder="./venv"  # venv folder name
venv_prompt=""
venv_indicator=""
venv_manually_deactivated=false

function chpwd {
  venv_manually_deactivated=false
}

function format_venv_indicator {
  if ! [[ -z $venv_prompt ]]
  then
    venv_indicator="[using %F{red}$venv_prompt%f]"  # indicator format
  else
    venv_indicator=""
  fi
}

function check_venv {
  venv_prompt=""

  if [[ -z $VIRTUAL_ENV ]] && [[ -d $venv_folder ]] && ! $venv_manually_deactivated
  then
    unalias deactivate 2>/dev/null
    source $venv_folder/bin/activate
  fi

  if ! [[ -z $VIRTUAL_ENV ]]
  then
    alias deactivate="venv_manually_deactivated=true; deactivate; unalias deactivate 2>/dev/null"
    if ! [[ -d $VIRTUAL_ENV ]] || [[ $PWD/ != $(dirname $VIRTUAL_ENV)/* ]]
    then
      venv_manually_deactivated=false
      unalias deactivate 2>/dev/null
      deactivate
      check_venv
    elif [[ $(cat $VIRTUAL_ENV/pyvenv.cfg) =~ "prompt = '(.*)'" ]]
    then
      venv_prompt=$match
    else
      venv_prompt=${VIRTUAL_ENV##*/}
    fi
  fi

  format_venv_indicator
}

autoload -U add-zsh-hook
add-zsh-hook precmd check_venv
