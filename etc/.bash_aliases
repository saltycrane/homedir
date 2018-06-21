echo "sourcing ~/etc/.bash_aliases..." 1>&2

# https://github.com/sharkdp/bat
alias cat='bat'

# https://github.com/sharkdp/fd
# alias find='fd'

# https://github.com/ogham/exa
alias ls='exa --sort Name --group-directories-first'
alias ll='ls -l --git --time-style long-iso'
alias la='ll -a'
alias lr='ll --sort newest'

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
alias inc='cd ~/incoming'
alias dc='docker-compose'
