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

# Android SDK
export ANDROID_SDK_ROOT=$HOME/Android/Sdk/

# GOROOT
. ~/.asdf/plugins/golang/set-env.zsh

#zoxide
eval "$(zoxide init zsh)"

# aliases
alias zz="nvim ~/.zshrc"
alias zzz="nvim ~/.config/i3/config"
alias c="clear"
alias vim="nvim"
alias eza="eza --icons --group-directories-first"
alias ls="eza --group-directories-first -l"
alias l="eza -lah --group-directories-first"
alias ll="eza -la --group-directories-first"
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias disable-audio="bash -c \"systemctl --user stop pipewire.socket\""
alias brightness="sudo vim /sys/class/backlight/amdgpu_bl1/brightness"
alias fff="yarn rw prisma format"

