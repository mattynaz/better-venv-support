# Better Shell Support for Python Virtual Environments
Format Python virtual environment indicators and have them automatically activate/deactivate upon creation, deletion, and `cd`ing.

![demo](https://i.imgur.com/Q52G8pO.gif)

## Installation
This extension only works for the default Python virtual environment module (the [venv](https://docs.python.org/3/library/venv.html#module-venv) module). Paste the contents of [`extension.sh`](extension.sh) at the top of your `~/.zshrc` file (or bash profile, etc). When you do, consider two possible configurations:
- the format of the indicator;
```sh
venv_folder="./venv"  # venv folder name
```
- the name of the venv folder to search for when auto-activating (`./venv` by default).
```sh
venv_indicator="[using %F{red}$venv_prompt%f]"  # indicator format
```

To use the indicator in your shell prompt, put `$venv_indicator` in your prompt variable:
```sh
PROMPT='%~ $venv_indicator > '
```

Finally, remember to set the text of the indicator when creating your virtual environment:
```sh
python -m venv venv --prompt "project venv"
```
