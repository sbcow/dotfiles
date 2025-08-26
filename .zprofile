if [ -x /usr/libexec/path_helper ]; then
        PATH="" # <- ADD THIS LINE (right before path_helper call)
        eval `/usr/libexec/path_helper -s`
fi

export CLICOLOR=1
export PATH=/usr/local/bin:$PATH
# export EDITOR=vim
# export EDITOR=/usr/local/bin/nvim
ctags=/usr/local/bin/ctags
export PATH=/Users/sean.cowan/homebrew/bin:$PATH

rmext() {
    if [ "$1" != "" ]; then # or better, if [ -n "$1" ]
        echo | find . -name "$1" -type f
        find . -name "$1" -type f -delete
    fi
}

