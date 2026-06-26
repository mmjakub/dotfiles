# XDG
export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_CACHE_HOME="$HOME/.cache"

# PATH
[[ -d ~/bin ]] && export PATH="$HOME/bin:$PATH"
[[ -d ~/.local/bin ]] && export PATH="$PATH:$HOME/.local/bin"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

export EDITOR="nvim"
export VISUAL="nvim"
export LESS="--use-color -R"

# M$
export AZURE_DEV_COLLECT_TELEMETRY="no"

# Wayland fixes
export ELECTRON_OZONE_PLATFORM_HINT=wayland

