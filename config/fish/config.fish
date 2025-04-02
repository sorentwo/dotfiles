eval (/opt/homebrew/bin/brew shellenv)

set fish_cursor_unknown block
set fish_cursor_default block

# source ~/.asdf/asdf.fish
# source ~/.cargo/env.fish

set -x PATH \
  "$HOME/.asdf/shims" \
  "$HOME/.cargo/bin" \
  "$HOME/.asdf/bin" \
  "$HOME/.local/bin" \
  /Users/parker/Work/Code/elixir-ls/rel \
  /opt/homebrew/sbin \
  /opt/homebrew/bin \
  /opt/homebrew/opt/fzf/bin \
  /usr/local/bin \
  /usr/bin \
  /bin \
  /usr/local/sbin \
  /usr/sbin \
  /sbin
