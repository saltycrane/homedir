echo "sourcing ~/etc/.bash_aliases..." 1>&2

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# tools aliases
alias ls='ls --color=auto --time-style="+%Y %m/%d %H:%M"'
alias la='ls -lA --hide "*~" --hide "*.bak" --hide "*.orig"'
alias laa='ls -lA'
alias ll='ls -l --hide "*~" --hide "*.bak" --hide "*.orig" --hide "*.pyc" --hide "*.o"'
alias lr='ll -qt'
alias lh='lr | head -20'
alias lx='ll -X'
alias dir='ll'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias h='history'
alias tracked='hg status -marcdu'
alias ps='ps --forest'
alias go='gnome-open'
alias dotme="source ~/.bashrc"
alias diff="colordiff -u"
alias svndiff="svn diff | colordiff"
alias whatismyip='curl ifconfig.me'
alias uphist='history -n'
alias go='xdg-open'
alias gi='git'
alias less='less -R'
# alias recfind="find -type f -printf '%T@ %p\0' |sort -zk 1nr |sed -z 's/^[^ ]* //' |xargs -0n1"

# directory aliases
alias inc='cd ~/incoming'
alias loc="cd ~/local/$HOSTNAME"
