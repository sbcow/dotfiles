 if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
   exec tmux
   tmux source-file ~/.tmux.conf
 fi

if [ -x /usr/libexec/path_helper ]; then
        PATH="" # <- ADD THIS LINE (right before path_helper call)
        eval `/usr/libexec/path_helper -s`
fi

export CLICOLOR=1
# export EDITOR=vim
# export EDITOR=/usr/local/bin/nvim
ctags=/usr/local/bin/ctags

rmext() {
    if [ "$1" != "" ]; then # or better, if [ -n "$1" ]
        echo | find . -name "$1" -type f
        find . -name "$1" -type f -delete
    fi
}
