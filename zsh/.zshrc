# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# fix git signing error
export GPG_TTY=$(tty)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#antidote friendlier plugin directory names
zstyle ':antidote:bundle' use-friendly-names 'yes'

# setup antidote
antidote load

# asdf autocompletions
fpath=(${ASDF_DIR}/completions $fpath)

# setup autocompletions
autoload -Uz compinit && compinit

# setup rust
source "$HOME/.cargo/env"

export PATH=$PATH:/home/daniel/bin

# editor
export EDITOR=nvim

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

