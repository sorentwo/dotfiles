source ~/.asdf/asdf.fish
set PATH $HOME/.rbenv/bin $HOME/.rbenv/shims ./bin $PATH
rbenv rehash >/dev/null ^&1
