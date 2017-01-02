HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v

autoload zmv
alias zmv='noglob zmv'
alias zcp='noglob zmv -C'
alias zln='noglob zmv -L'
alias zsy='noglob zmv -Ls'
alias rake='noglob rake'

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
path=(./bin $HOME/.rbenv/shims $HOME/Work/Code/go/bin $HOME/.cargo/bin $HOME/.yarn/bin /usr/local/opt/go/libexec/bin /usr/local/bin /usr/bin $HOME/.rbenv/bin $path)

# rbenv
###############################################################################

eval "$(rbenv init -)"

# Bundler
###############################################################################

alias be='bundle exec'

# Vim Aliases
###############################################################################

alias vim="nvim"
alias vi="nvim"

# Preferences
###############################################################################

export EDITOR=nvim

# Autocorrect Bypass
###############################################################################

alias cap='nocorrect cap'
alias lein='nocorrect lein'
alias rspec='nocorrect rspec'
alias spring='nocorrect spring'
alias tmux='nocorrect tmux'

# Global Convenience
###############################################################################

alias agpl="ag -l '$1' | xargs perl -pi -E 's/$1/$2/g'"
alias rds="redis-server /usr/local/etc/redis.conf"

# SSL Certification
###############################################################################

export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# Go Variables
###############################################################################

export GOPATH=$HOME/Work/Code/go
