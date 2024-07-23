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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

