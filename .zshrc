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
alias ssh_llof="ssh sean@10.182.0.53"
alias ssh_emma="ssh sbcow@10.181.126.218"

alias restartkernel='exec zsh -l'
alias jupyterlab='jupyter-lab > jupyter-lab.log 2>&1 &'
alias jupyterlab='jupyter-lab > jupyter-lab.log 2>&1 &'
alias marimoedit='marimo edit 2>&1 &'
alias jupyter-remote="ssh -L 8887:localhost:8887 sean@10.182.0.53 'source /home/sean/miniconda3/etc/profile.d/conda.sh && conda activate ll-of && jupyter-lab --no-browser --port=8887'"
alias tmux-reload='tmux source-file ~/.tmux.conf'
alias tmux-kill-sesh='tmux kill-session -t'

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
export PATH="/Users/sean.cowan/code/system/nvim-macos-arm64/bin:$PATH"
export PATH="/Users/sean.cowan/homebrew/bin:$PATH"
export PATH="/Users/sean.cowan/code/texlive/bin/universal-darwin:$PATH"
export PATH="/Users/sean.cowan/apps/Visual\ Studio\ Code.app:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/sean.cowan/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/sean.cowan/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/sean.cowan/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/sean.cowan/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/sean.cowan/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/sean.cowan/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/sean.cowan/.juliaup/bin' $path)


# <<< juliaup initialize <<<

# Navigate through history with partial search using arrow keys
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# # Auto start tmux
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#  tmux source-file ~/.tmux.conf
# fi

