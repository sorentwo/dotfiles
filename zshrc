HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v

autoload -Uz compinit
compinit

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="endre"

export CASE_SENSITIVE="true"
export DISABLE_AUTO_UPDATE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Paths
########################################################################

typeset -U path
path=(./bin $HOME/.rbenv/shims $HOME/Work/Code/go/bin /usr/local/bin /usr/bin /usr/local/share/npm/bin $HOME/.rbenv/bin $path)

# rbenv
###############################################################################

eval "$(rbenv init -)"

# Bundler
###############################################################################

alias be='bundle exec'

# Macvim Aliases
###############################################################################

alias vim="mvim -v"
alias vi="mvim -v"

# Preferences
###############################################################################

export EDITOR=vim

# Autocorrect Bypass
###############################################################################

alias bower='noglob bower'
alias cap='nocorrect cap'
alias lein='nocorrect lein'
alias rspec='nocorrect rspec'
alias spring='nocorrect spring'
alias tmux='nocorrect tmux'

# Global Convenience
###############################################################################

alias agpl="ag -l '$1' | xargs perl -pi -E 's/$1/$2/g'"
alias rds="redis-server /usr/local/etc/redis.conf"
alias pgs="pg_ctl start -D /usr/local/var/postgres-9.4 -l /usr/local/var/postgres-9.4/server.log"
alias vfg="fg &>/dev/null || vim"

# SSL Certification
###############################################################################

export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# Go Variables
###############################################################################

export GOPATH=$HOME/Work/Code/go

export NVM_DIR="/Users/pselbert/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
