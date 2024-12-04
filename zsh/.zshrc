# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

#antidote friendlier plugin directory names
zstyle ':antidote:bundle' use-friendly-names 'yes'

# setup antidote
antidote load

autoload -Uz promptinit && promptinit && prompt pure

fpath+=~/.zfunc

# setup autocompletions
autoload -Uz compinit && compinit

# editor
export EDITOR=nvim
export VISUAL=nvim

export PATH="$PATH:$HOME/bin"

#neovim as manpager
export MANPAGER="nvim +Man!"

# fix git signing error
export GPG_TTY=$(tty)

# mise
eval "$(~/.local/bin/mise activate zsh)"

# setup rust
source "$HOME/.cargo/env"

# Android SDK
export ANDROID_SDK_ROOT=$HOME/Android/Sdk/

export NODE_OPTIONS=--use-openssl-ca

# pipx
export PATH="$PATH:$HOME/.local/bin"

#zoxide
eval "$(zoxide init zsh)"

# For my laptop. Saves battery life 👍
SERVICES=(postgresql minio docker.socket docker.service redis nginx libvirtd.socket libvirtd.service)
function start_services {
  for service in "${SERVICES[@]}"; do
    sudo systemctl start $service
    echo "Started ${service}"
  done
}
function stop_services {
  for service in "${SERVICES[@]}"; do
    sudo systemctl stop $service
    echo "Stopped ${service}"
  done
}

# aliases
alias grep='grep --color=auto'
alias zz="nvim ~/.zshrc"
alias zzz="nvim ~/.config/i3/config"
alias za="nvim ~/.config/hypr/hyprland.conf"
alias c="clear"
alias eza="eza --icons --group-directories-first"
alias ls="eza --group-directories-first -l"
alias l="eza -lah --group-directories-first"
alias ll="eza -la --group-directories-first"
alias pacman="sudo pacman"
alias lg="lazygit"
alias lz="lazydocker"
alias disable-audio="bash -c \"systemctl --user stop pipewire.socket\""
alias brightness="sudo vim /sys/class/backlight/amdgpu_bl1/brightness"
alias fixx="xset r rate 300 && setxkbmap -layout us,us_intl,br -option 'grp:alt_shift_toggle'"
alias v="source .venv/bin/activate"
alias grepc="grep --color=always -e \"^\" -e"
alias p="start_services"
alias pp="stop_services"

source $HOME/.zsh_config/.zshrc_custom
