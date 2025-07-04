#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
alias h="history"
alias pdf='zathura'
alias btop='bashtop'

PS1='[\u@\h \W]\$ '

# Launch programs detached
launch() {
    "$@" > /dev/null 2>&1 & disown
}

# Specific alacritty launcher
alac() {
    alacritty > /dev/null 2>&1 & disown
}
export MOZ_X11_EGL=1
export MOZ_ENABLE_WAYLAND=0
export PATH=~/.npm-global/bin:$PATH

# Apptainer configuration
export APPTAINER_CACHEDIR="$HOME/.containers/cache"
export APPTAINER_TMPDIR="$HOME/.containers/tmp"
export SINGULARITY_CACHEDIR="$HOME/.containers/cache"
export SINGULARITY_TMPDIR="$HOME/.containers/tmp"

# Terminal greeting with ASCII art and Berkeley weather
if [[ $- == *i* ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]]; then
    if [[ -x "$HOME/dev/i3-neobrutalist-config/.config/terminal-greeting.sh" ]]; then
        "$HOME/dev/i3-neobrutalist-config/.config/terminal-greeting.sh"
    fi
fi
