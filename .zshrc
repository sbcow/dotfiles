# For each interactive session:
# - Aliases to shorten commands
# - Functions for complex tasks
# - Path exports for software
# - Prompt customizations

#Prompt Customization
PROMPT='%F{red}%*%f %F{white}%?%f %B%F{yellow}%2~%f%b %% '

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '
zstyle ':vcs_info:git:*' formats '%b'


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
alias jupyterlab='jupyter-lab > jupyter-lab.log 2>&1 &'
alias marimoedit='marimo edit 2>&1 &'
alias jupyter-remote-llof="ssh -L 8887:localhost:8887 sean@10.182.0.53 'source /home/sean/miniconda3/etc/profile.d/conda.sh && conda activate ll-of && jupyter-lab --no-browser --port=8887'"
alias jupyter-remote-emma-taymod="ssh -L 8887:localhost:8887 sbcow@emma 'source /home/sbcow/miniforge3/etc/profile.d/conda.sh && conda activate taymod && jupyter-lab --no-browser --port=8887'"
alias jupyter-remote-emma-audi="ssh -L 8887:localhost:8887 sbcow@emma 'source /home/sbcow/miniforge3/etc/profile.d/conda.sh && conda activate audi && jupyter-lab --no-browser --port=8887'"
alias tmux-reload='tmux source-file ~/.tmux.conf'
alias tmux-kill-sesh='tmux kill-session -t'
alias ca='conda activate'

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [[ $- == *i* ]]; then   # only for interactive shells
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
  # <<< conda initialize <<<

  conda activate base
fi
