# History
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_VERIFY

. $XDG_CONFIG_HOME/aliases

_comp_options+=(globdots)
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

#AWS
complete -C '/usr/bin/aws_completer' aws

#AZ
. /usr/share/bash-completion/completions/az

# Prompt
. /usr/share/git/completion/git-prompt.sh
#%F{red}%(?..=)
setopt PROMPT_SUBST ; PS1='%F{green}%1~%F{blue}$(__git_ps1 " (%s)")%(?.%F{green}.%F{red})\$%F{reset} '

# Binds
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
#bindkey '^R' history-incremental-search-backward
bindkey -M viins '\e.' insert-last-word

# FZF
fzf_dir=/usr/share/fzf
if [ -d $fzf_dir ]; then
    . $fzf_dir/completion.zsh
    . $fzf_dir/key-bindings.zsh
fi

# vi cursor
bindkey -v
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    printf '\e[2 q'
  else
    printf '\e[6 q'
  fi
}
zle -N zle-keymap-select
precmd() { printf '\e[6 q' }
