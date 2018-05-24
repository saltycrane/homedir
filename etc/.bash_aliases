echo "sourcing ~/etc/.bash_aliases..." 1>&2

# alias ls='ls -G'
# alias la='ls -lA'
# alias ll='ls -l'
# alias lr='ll -qt'
# alias lh='lr | head -20'
# alias lx='ll -X'

# https://github.com/ogham/exa
alias ls='exa --sort Name --group-directories-first'
alias ll='ls -l --git --time-style long-iso'
alias la='ll -a'
alias lr='ll --sort newest'

# https://github.com/sharkdp/bat
alias cat='bat'

# https://github.com/sharkdp/fd
# alias find='fd'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias h='history'
alias dotme="source ~/.bashrc"
alias diff="colordiff -u"
alias whatismyip='curl ifconfig.me'
alias uphist='history -n'

# directory aliases
alias inc='cd ~/incoming'
alias loc="cd ~/local/$HOSTNAME"
