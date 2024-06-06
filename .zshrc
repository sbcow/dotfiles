LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8


#Prompt Customization
PROMPT='%F{red}%*%f %F{white}%?%f %B%F{yellow}%2~%f%b %% '

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '
zstyle ':vcs_info:git:*' formats '%b'

lldbeigen() {
  lldb "$1" --local-lldbinit
}

###############
### Aliases ###
###############
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME/'

alias ll="ls -l"
alias lla="ls -la"
alias vim="nvim"
alias vimdiff="nvim -d"

alias restartkernel='exec zsh -l'
alias jupyterlab='jupyter-lab > jupyter-lab.log 2>&1 &'

#############
### Other ###
#############

check_volume_usage() {
    sudo lsof +d "/Volumes/$1" -x f +c 0
}

fpath+=${ZDOTDIR:-~}/.zsh_functions
#set -o vi
path+=('/opt/local/bin')
path+=('~/.local/bin')
export PATH

# export EDITOR=vim
# export EDITOR=/usr/local/bin/nvim
# export PATH="~/.local/bin:$PATH"
