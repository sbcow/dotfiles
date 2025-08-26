#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
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
