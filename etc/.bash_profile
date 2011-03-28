echo "sourcing ~/.bash_profile..." 1>&2

# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
