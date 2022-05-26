# Copy dotfiles from my system to this repo in order to use them in github.
copy_if_exists() {
    if [ -e $1 ]; then
        cp -r $1 $2
    else 
        echo "Directory $1 does not exist"
    fi
}

# Copy all home/bin files in bin folder
cp -r ~/bin/* ~/dotfiles/bin

# Copy *rc files in rc folder
cp ~/.*rc ~/dotfiles/rc

# Copy .xmonad folder in xmonad folder
copy_if_exists ~/.xmonad ~/dotfiles/xmonad

# Copy competitive programmign files in CP folder
cp -r ~/CP/templates ~/dotfiles/CP/templates

# Copy some config files to config
copy_if_exists ~/.config/nvim/init.vim ~/dotfiles/config
copy_if_exists ~/.config/alacritty ~/dotfiles/config
copy_if_exists ~/.config/picom ~/dotfiles/config
copy_if_exists ~/.config/xmobar ~/dotfiles/config
copy_if_exists ~/.config/qtile ~/dotfiles/config
copy_if_exists ~/.config/rofi/config.rasi ~/dotfiles/config
copy_if_exists ~/.config/i3 ~/dotfiles/config
copy_if_exists ~/.config/i3status ~/dotfiles/config
copy_if_exists ~/.config/polybar ~/dotfiles/config
copy_if_exists ~/.config/dunst ~/dotfiles/config
copy_if_exists ~/Pictures/Wallpapers ~/dotfiles

# powerlevel10k config
cp ~/.p10k.zsh ~/dotfiles/rc

cp ~/.tmux.conf ~/dotfiles/rc

echo "Dotfiles refreshed!"
