source ~/.asdf/asdf.fish
source ~/.poetry/env
source $HOME/.cargo/env
set PATH ./bin $PATH
set ERL_AFLAGS "-kernel shell_history enabled"
set HOMEBREW_GITHUB_API_TOKEN 87fd8561359bf13837cb6bdfc8c3eab43d18a191

set -l GRUVBOX_SCRIPT ~/.config/neovim/bundle/gruvbox/gruvbox_256palette.sh
if test -f $GRUVBOX_SCRIPT
    bash $GRUVBOX_SCRIPT
end
