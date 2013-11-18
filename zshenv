# Paths #######################################################################

typeset -U path
path=($HOME/.rbenv/shims /usr/local/bin /usr/bin /usr/local/share/npm/bin $HOME/.rbenv/bin $path)

# rbenv #######################################################################

eval "$(rbenv init -)"

# Prepend local bin, binstubs over global gems
path=(./bin $path)
