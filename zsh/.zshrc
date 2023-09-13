# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

#antidote friendlier plugin directory names
zstyle ':antidote:bundle' use-friendly-names 'yes'

# setup antidote
antidote load

autoload -Uz promptinit && promptinit && prompt pure

# asdf autocompletions
fpath=(${ASDF_DIR}/completions $fpath)

# setup autocompletions
autoload -Uz compinit && compinit

# setup rust
source "$HOME/.cargo/env"

export PATH=$PATH:/home/daniel/bin

# editor
export EDITOR=nvim

# fix git signing error
export GPG_TTY=$(tty)

# GOROOT
. ~/.asdf/plugins/golang/set-env.zsh

#zoxide
eval "$(zoxide init zsh)"

# aliases
alias zz="nvim ~/.zshrc"
alias zzz="nvim ~/.config/i3/config"
alias c="clear"
alias vim="nvim"
alias exa="exa --icons --group-directories-first"
alias ls="exa --group-directories-first -l"
alias l="exa -lah --group-directories-first"
alias ll="exa -la --group-directories-first"
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias brightness="sudo vim /sys/class/backlight/amdgpu_bl1/brightness"

