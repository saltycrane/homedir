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
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
