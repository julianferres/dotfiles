set mouse=a             " enable mouse support (might not work well on Mac OS X)
set number relativenumber
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw screen only when we need to
set showmatch           " highlight matching parentheses / brackets [{()}]
set laststatus=2        " always show statusline (even with only single window)
set ruler               " show line and column number of the cursor on right side of statusline
set visualbell 

"Me deja usar ctrl-s y ctrl-q para otras cosas
silent !stty -ixon
autocmd VimLeave * silent !stty ixon

"""" Key Bindings

" move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk
nmap E ge

"Ctrl-A Ctrl-C Ctrl-V
map gA m'ggVG"+y''

"Move lines
xnoremap <C-k> :move '<-2<CR>gv=gv
xnoremap <C-j> :move '>+1<CR>gv=gv

"Insertar lineas arriba y abajo
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>j

"fzf
map <c-p> :Files .<CR>

"NERDTree
nmap <F6> :NERDTreeToggle<CR>


" use filetype-based syntax highlighting, ftplugins, and indentation
syntax enable
filetype plugin indent on
syntax on

"Set up vertical vs block cursor for insert/normal mode
if &term =~ "screen."
    let &t_ti.="\eP\e[1 q\e\\"
    let &t_SI.="\eP\e[5 q\e\\"
    let &t_EI.="\eP\e[1 q\e\\"
    let &t_te.="\eP\e[0 q\e\\"
else
    let &t_ti.="\<Esc>[1 q"
    let &t_SI.="\<Esc>[5 q"
    let &t_EI.="\<Esc>[1 q"
    let &t_te.="\<Esc>[0 q"
endif

"""" Tab settings

set tabstop=4           " width that a <TAB> character displays as
set expandtab           " convert <TAB> key-presses to spaces
set shiftwidth=4        " number of spaces to use for each step of (auto)indent
set softtabstop=4       " backspace after pressing <TAB> will remove up to this many spaces

set autoindent          " copy indent from current line when starting a new line
set smartindent         " even better autoindent (e.g. add indent after '{')
set smarttab
set smartcase

"""" Search settings

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
set ignorecase " search case insensitive

"""" Miscellaneous settings that might be worth enabling

set cursorline   " highlight current line
set background=dark    " configure Vim to use darker colors
set autoread           " autoreload the file in Vim if it has been changed outside of Vim
set clipboard=unnamedplus

"""" Plugins

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'github/copilot.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mxw/vim-jsx'
Plug 'preservim/nerdcommenter'
"Plug 'zxqfl/tabnine-vim'
Plug 'tpope/vim-unimpaired'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }
call plug#end()


set nocompatible              " be iMproved, required
filetype off                  " required
runtime macros/matchit.vim

" Atajos para easymotion
let mapleader=" "
map <Leader>s <Plug>(easymotion-s2)

"fzf
let $FZF_DEFAULT_OPTS='--reverse'
"let g:fzf_layout = { 'window' : { 'width': 0.8, 'height': 0.8 } }

"""""" Competitive programming shorcuts
autocmd filetype cpp nnoremap <F8> :w <bar> ! g++ -std=c++17 -DLOCAL -Wall -g -O2 -Wconversion -Wshadow -Wextra % -o %:r && ./%:r <CR>
filetype plugin indent on    " required

autocmd filetype python nnoremap <F8> :w <bar> !python3 % <CR>

set showcmd
let g:UltiSnipsExpandTrigger = '<f5>' 

"Comandos de guardar
nmap <c-s> :w<cr>
imap <c-s> <Esc>:w<cr>

"hi signcolumn ctermbg=235
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

"let g:vim_monokai_tasty_italic = 1
"colorscheme vim-monokai-tasty

"let g:airline_theme='monokai_tasty'

