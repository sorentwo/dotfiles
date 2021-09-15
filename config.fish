source ~/.asdf/asdf.fish

set -x PATH $PATH "$HOME/.cargo/bin" /usr/local/bin /usr/local/sbin

set -l GRUVBOX_SCRIPT ~/.config/neovim/bundle/gruvbox/gruvbox_256palette.sh
if test -f $GRUVBOX_SCRIPT
    bash $GRUVBOX_SCRIPT
end

