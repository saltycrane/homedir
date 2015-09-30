echo "sourcing ~/etc/.bash_aliases..." 1>&2

# tools aliases
# alias ls='ls --color=auto --time-style="+%Y %m/%d %H:%M"'
# alias la='ls -lA --hide "*~" --hide "*.bak" --hide "*.orig"'
# alias laa='ls -lA'
# alias ll='ls -l --hide "*~" --hide "*.bak" --hide "*.orig" --hide "*.pyc" --hide "*.o"'
alias ls='ls -G'
alias la='ls -lA'
alias ll='ls -l'
alias lr='ll -qt'
alias lh='lr | head -20'
alias lx='ll -X'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias h='history'
alias tracked='hg status -marcdu'
# alias ps='ps --forest'
alias go='gnome-open'
alias dotme="source ~/.bashrc"
alias diff="colordiff -u"
alias svndiff="svn diff | colordiff"
alias whatismyip='curl ifconfig.me'
alias uphist='history -n'
alias go='xdg-open'
alias gi='git'
# alias less='less -R'
# alias recfind="find -type f -printf '%T@ %p\0' |sort -zk 1nr |sed -z 's/^[^ ]* //' |xargs -0n1"

# directory aliases
alias inc='cd ~/incoming'
alias loc="cd ~/local/$HOSTNAME"
