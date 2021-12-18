# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/julian/.oh-my-zsh"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="random"

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
    docker
    docker-compose
    fd
    fzf
    fzf-tab
    git
    history-substring-search
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

export EDITOR='vim'

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
function plantilla(){
    for problem
    do cp ~/CP/templates/problem/main.cpp "${problem%%.*}".cpp
    done
}
function plantilla_py(){
    for problem
    do cp ~/CP/templates/problem/main.py "${problem%%.*}".py
    done
}
function rmd(){ sudo rm -r $@ }

alias v="vim"
alias p="python3"
alias grep="grep --color=auto"

# Switch to exa instead of ls
alias ls="exa -G"
alias ll="exa -lh"
alias lst="exa -T"
alias lsr="exa -r"

alias alacrittyconfig="vi ~/.config/alacritty/alacritty.yml"
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias open="xdg-open"

# Git aliases
alias gaa="git add -A"
alias gcm="git commit -m"
alias gp="git push"

fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

alias gb='fzf-git-branch'
alias gcol='fzf-git-checkout'


##History variables
## grip es el programa que pasa de markdown a pdf

if type rg &> /dev/null; then
    export FZF_ALT_C_COMMAND='fdfind'
fi


## Markdown server: grip
#https://github.com/sharkdp/bat/issues/448

if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/julian/google-cloud-sdk-359.0.0-linux-x86_64/google-cloud-sdk/path.zsh.inc' ]; then . '/home/julian/google-cloud-sdk-359.0.0-linux-x86_64/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/julian/google-cloud-sdk-359.0.0-linux-x86_64/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/julian/google-cloud-sdk-359.0.0-linux-x86_64/google-cloud-sdk/completion.zsh.inc'; fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH=/opt/apache-maven-3.8.4/bin:$PATH
export PATH=/home/julian/Applications:$PATH

