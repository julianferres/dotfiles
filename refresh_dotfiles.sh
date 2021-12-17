# Copy dotfiles from my system to this repo in order to use them in github.

# Copy all home/bin files in bin folder
cp -r ~/bin/* bin

# Copy *rc files in rc folder
cp ~/.*rc rc

# Copy .xmonad folder in xmonad folder
cp -r ~/.xmonad/* xmonad

# Copy competitive programmign files in CP folder
cp -r ~/CP/templates/* CP/templates
cp ~/CP/dorito.jpg CP

# Copy some config files to config
cp -r ~/.config/nvim config
cp -r ~/.config/alacritty config
cp -r ~/.config/picom config
cp -r ~/.config/xmobar config

echo "Dotfiles refreshed!"

