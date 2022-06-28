# Path to your oh-my-zsh installation.
export ZSH="/home/julian/.oh-my-zsh"
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="spaceship"
#ZSH_THEME="pygmalion-virtualenv"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
#ZSH_TMUX_AUTOSTART=true

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"nada

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    alias-tips
    autojump
    colored-man-pages
    colorize
    copydir
    copyfile
    dirhistory
    docker
    docker-compose
    fd
    fzf
    fzf-tab
    git
    history-substring-search
    sudo
    tmux
    web-search
    z
    zsh-autosuggestions
    zsh-interactive-cd
    zsh-syntax-highlighting 
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'
export TERMINAL='alacritty'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
function makefile(){ cp ~/CP/templates/problem/Makefile .  }
function estufa(){
    for problem
    do cp ~/CP/templates/problem/main.cpp "${problem%%.*}".cpp
    done
}
function estufapy(){
    for problem
    do cp ~/CP/templates/problem/main.py "${problem%%.*}".py
    done
}
function refresh_dotfiles(){
    ~/dotfiles/refresh_dotfiles.sh
}

alias v="nvim"
alias vim="nvim"
alias p="python3"
alias python="python3"
alias grep="grep --color=auto"

# Switch to exa instead of ls
alias ls="exa -G"
alias ll="exa -lh"
alias lst="exa -T"
alias lsr="exa -r"

alias alacrittyconfig="vim ~/.config/alacritty/alacritty.yml"
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias i3config="vim ~/.config/i3/config"
alias i3statusconfig="vim ~/.config/i3status/config"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias polybarconfig="vim ~/.config/polybar/forest"
alias dunstconfig="vim ~/.config/dunst/dunstrc"
alias picomconfig="vim ~/.config/picom/picom.conf"
alias cpboosterconfig="vim ~/.config/cpbooster/cpbooster-config.json"

alias open="xdg-open"

alias ncdu="ncdu --color=dark"
alias cat="bat"

# Git aliases
alias gaa="git add -A"
alias gcm="git commit -m"
alias gp="git push"

# Lazy-something alias
alias lg='lazygit'
alias lzd='lazydocker'

# Cpbooster
alias cpb="cpbooster"

# Themes
function good-morning(){
    # Applications theme
    gsettings set org.gnome.desktop.interface gtk-theme "Material-Originals-Gtk-Orange-Light"
    # Shell theme
    gsettings set org.gnome.shell.extensions.user-theme name "Material-Originals-Shell-40-Orange-Light"
    # Cursor theme
    gsettings set org.gnome.desktop.interface cursor-theme "DeppinDark-cursors"
}
function good-night(){
    # Applications theme
    gsettings set org.gnome.desktop.interface gtk-theme "Material-Originals-Gtk-Orange-Dark"
    # Shell theme
    gsettings set org.gnome.shell.extensions.user-theme name "Material-Originals-Shell-40-Orange-Dark"
    # Cursor theme
    gsettings set org.gnome.desktop.interface cursor-theme "DeppinWhite-cursors"
}

#if type rg &> /dev/null; then
    #export FZF_ALT_C_COMMAND='fdfind'
#fi
#export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*,target/*}"'

# Exclude those directories even if not listed in .gitignore, or if .gitignore is missing
FD_OPTIONS="--follow --exclude .git --exclude node_modules"

# Change behavior of fzf dialogue
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"

# Change find backend
# Use 'git ls-files' when inside GIT repo, or fd otherwise
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"

# Find commands for "Ctrl+T" and "Opt+C" shortcuts
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

## Markdown server: grip
#https://github.com/sharkdp/bat/issues/448

if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

if [ -s ~/.xinitrc ]; then
    source ~/.xinitrc
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH=$PATH:/home/julian/Applications
export PATH=$PATH:/home/julian/bin
export PATH=$PATH:/home/julian/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/julian/Isabelle2021/bin

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NO_AT_BRIDGE=1 

export RCLONE_VISA_LOCAL=~/Desktop/FB-UK/Visa
export RCLONE_VISA_REMOTE=julianferres-gdrive:FB-UK/Visa

export BAT_THEME="Dracula"

[ -f "/home/julian/.ghcup/env" ] && source "/home/julian/.ghcup/env" # ghcup-env

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

