# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/parker/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="endre"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Environment Variables
###############################################################################

if [[ -f ~/.envrc ]]; then
  source ~/.envrc
fi

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

alias bundle='nocorrect bundle'
alias lein='nocorrect lein'
alias rspec='nocorrect rspec'
alias tmux='nocorrect tmux'
alias bower='noglob bower'

# Heroku
###############################################################################

alias hcp="heroku run console -r production"
alias hcs="heroku run console -r staging"
alias htp="heroku logs -t -r production"
alias hts="heroku logs -t -s staging"

# Global Convenience
###############################################################################

alias arp="ack -l '$1' | xargs perl -pi -E 's/$1/$2/g'"

# added by travis gem
source /Users/pselbert/.travis/travis.sh
