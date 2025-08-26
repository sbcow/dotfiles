#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

alias ll='ls -la'
alias vim='nvim'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME/'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\$(parse_git_branch)\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"

#Navigate the hystory with arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sbcow/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sbcow/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/sbcow/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sbcow/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/sbcow/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/sbcow/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

. "$HOME/.cargo/env"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/sbcow/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/sbcow/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

# Added by Neovim source installer
export PATH="/home/sbcow/local/nvim/bin:$PATH"
