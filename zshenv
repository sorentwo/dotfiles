# Paths #######################################################################

typeset -U path
path=(./bin /usr/local/bin /usr/bin $path)

# rbenv #######################################################################

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
