# echo "sourcing ~/.bashrc..." 1>&2

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# see also .inputrc for editing mode

source $HOME/etc/.bash_prompt
source $HOME/etc/.environvars
source $HOME/etc/.bash_aliases
source $HOME/etc/.bash_functions
source $HOME/prv/.bashrc

# source machine specific .bashrc
if [ -f ~/local/${HOSTNAME}/etc/.bashrc ]; then
    . ~/local/${HOSTNAME}/etc/.bashrc
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# make fzf history search unique
# https://github.com/junegunn/fzf/issues/1309
# https://unix.stackexchange.com/questions/48713/how-can-i-remove-duplicates-in-my-bash-history-preserving-order
# modified:
#  - use "history" instead of cat ~/.bash_history (I think there was extra whitespace at beginning)
#  - reverse the first sort so that the last item is kept instead of the first when doing uniq
__fzf_history__() (
    local line
    shopt -u nocaseglob nocasematch
    line=$(
        HISTTIMEFORMAT= history | sort -r -k 2 | uniq -f 1 | sort -n |
            FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac --sync -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
            command grep '^ *[0-9]'
        ) &&
        if [[ $- =~ H ]]; then
            sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
        else
            sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
        fi
)
