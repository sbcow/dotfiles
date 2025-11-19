# Once at login; for:
# - Set system-wide environment variables
# - Run initialization scripts

# Locale
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Clear path and initialize system default
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

# Prepend custom paths (highest priority first)
typeset -U path  # remove duplicates automatically
path=(
    /opt/homebrew/bin
    /usr/local/bin
    /Users/sean.cowan/homebrew/bin
    # /Users/sean.cowan/code/system/nvim-macos-arm64/bin
    /Users/sean.cowan/code/system/bin/neovim/bin
    /Users/sean.cowan/code/texlive/bin/universal-darwin
    /Users/sean.cowan/.juliaup/bin
    /opt/local/bin
    ~/.local/bin
    $path
)
export PATH

export CLICOLOR=1

# EDITOR, CTAGS
export EDITOR=nvim
ctags=/usr/local/bin/ctags

# Conda
if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniforge3/etc/profile.d/conda.sh"
fi

# Mamba
if [ -f "$HOME/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "$HOME/miniforge3/etc/profile.d/mamba.sh"
fi
