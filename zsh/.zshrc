# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

#antidote friendlier plugin directory names
zstyle ':antidote:bundle' use-friendly-names 'yes'

# setup antidote
antidote load

# asdf autocompletions
fpath=(${ASDF_DIR}/completions $fpath)

# setup autocompletions
autoload -Uz compinit && compinit

# starship prompt
eval "$(starship init zsh)"

# setup rust
source "$HOME/.cargo/env"

export PATH=$PATH:/home/daniel/bin

# fix git signing error
export GPG_TTY=$(tty)

# aliases
alias z="nvim ~/.zshrc"
alias zz="nvim ~/.config/i3/config"
alias c="clear"
alias vim="nvim"
alias exa="exa --icons --group-directories-first"
alias ls="exa --group-directories-first -l"
alias l="exa -lah --group-directories-first"
alias ll="exa -la --group-directories-first"
alias dnf="sudo dnf"
alias pacman="sudo pacman"
alias docker="sudo docker"
alias docker-compose="sudo docker compose"
alias systemctl="sudo systemctl"
