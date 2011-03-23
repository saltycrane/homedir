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

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*|screen)
#     PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#     ;;
# *)
#     ;;
# esac

source $HOME/etc/.bash_prompt
source $HOME/etc/.environvars
source $HOME/etc/.bash_aliases
source $HOME/prv/.bashrc

# setup machine specific config files
python ~/bin/bashrc.py

# source machine specific .bashrc
if [ -f ~/local/${HOSTNAME}/etc/.bashrc ]; then
    . ~/local/${HOSTNAME}/etc/.bashrc
fi

# set up keyboard mapping
if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
