# For each interactive session:
# - Aliases to shorten commands
# - Functions for complex tasks
# - Path exports for software
# - Prompt customizations

# Load the 'vcs_info' function, which provides information about the
# current version control system (Git, Mercurial, etc.)
autoload -Uz vcs_info

# Define a function that runs vcs_info before each prompt is drawn
# This updates the Git branch info for the current directory.
precmd_vcs_info() { vcs_info }

# Add 'precmd_vcs_info' to the list of functions that run before
# each prompt is displayed (precmd_functions is a Zsh array)
precmd_functions+=( precmd_vcs_info )

# Enable prompt string substitution so variables like ${vcs_info_msg_0_}
# and conditionals (e.g. %?) are evaluated before showing the prompt.
setopt prompt_subst

# Set the format for Git branches in vcs_info:
# %b = branch name, wrapped in parentheses and shown in blue (%F{blue})
# %f resets the color back to default
zstyle ':vcs_info:git:*' formats '%F{blue}(%b)%f'

# Enable vcs_info for Git (it supports multiple version control systems)
zstyle ':vcs_info:*' enable git

# PROMPT defines the text shown as the main (left) prompt.
# Each part:
#   %F{red}  -> set text color to red
#   %*       -> show current time (HH:MM:SS)
#   %f       -> reset color
#   %F{white}%(?..✘ %?)%f  -> if the last command failed (%?), show "✘ <exit code>" in white
#   %B%F{yellow}%2~%f%b    -> show the current working directory (%2~ shows up to 2 directories deep)
#                             in bold yellow, then reset colors and boldness
#   ${vcs_info_msg_0_}     -> show Git branch info from vcs_info (e.g. (main))
#   ❯                      -> draw a right-pointing prompt character
PROMPT='%F{red}%*%f %F{white}%(?..✘ %?)%f %B%F{yellow}%2~%f%b ${vcs_info_msg_0_} ❯ '

# Aliases
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME/'

alias ll="ls -l"
alias lla="ls -la"
alias vim="nvim"
alias vimdiff="nvim -d"
alias ssh_llof="ssh sean@10.182.0.53"
alias ssh_emma="ssh sbcow@10.181.126.218"

alias restartkernel='exec zsh -l'
alias jupyterlab='jupyter-lab > jupyter-lab.log 2>&1 &'
alias marimoedit='marimo edit 2>&1 &'
alias tmux-reload='tmux source-file ~/.tmux.conf'
alias tmux-kill-sesh='tmux kill-session -t'
alias ca='conda activate'
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
alias unisoncloud='unison $HOME/Documents/nextcloud/Obsidian/Brain $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Brain'

# Other

check_volume_usage() {
    sudo lsof +d "/Volumes/$1" -x f +c 0
}

# Key bindings for history
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Use vi keybindings
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

lldbeigen() {lldb "$1" --local-lldbinit}
rmext() { [ -n "$1" ] && find . -name "$1" -type f -print -delete }

# fpath additions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Automatically start tmux in new interactive terminals
if [[ -o interactive && -z "$TMUX" ]] && command -v tmux >/dev/null 2>&1; then
    exec tmux new-session -A -s main
fi

# Miniforge: initialize Conda and activate base
if [[ -f "$HOME/Miniforge3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/Miniforge3/etc/profile.d/conda.sh"
    conda activate base
fi
