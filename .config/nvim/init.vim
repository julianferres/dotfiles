set mouse=a             " enable mouse support (might not work well on Mac OS X)
set number relativenumber
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw screen only when we need to
set showmatch           " highlight matching parentheses / brackets [{()}]
set laststatus=2        " always show statusline (even with only single window)
set ruler               " show line and column number of the cursor on right side of statusline
set visualbell 
set encoding=UTF-8

set rtp+=~/.fzf
source ~/.fzf/plugin/fzf.vim
source ~/.config/nvim/cp.vim

set noeb
set novb

"Me deja usar ctrl-s y ctrl-q para otras cosas
silent !stty -ixon
autocmd VimLeave * silent !stty ixon

"""" Key Bindings

" move vertically by visual line (don't skip wrapped lines)
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
map <c-p> :Files<CR>

"UndoTree
nmap <F7> :UndotreeToggle<CR>


" use filetype-based syntax highlighting, ftplugins, and indentation
syntax enable
filetype plugin indent on
syntax on

""Set up vertical vs block cursor for insert/normal mode
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
"This unsets the "last search pattern" register by hitting return
"nnoremap <CR> :noh<CR><CR>
set nohls

"""" Miscellaneous settings that might be worth enabling

set cursorline   " highlight current line
set background=dark    " configure Vim to use darker colors
set autoread           " autoreload the file in Vim if it has been changed outside of Vim
set clipboard=unnamedplus
set nocompatible              " be iMproved, required

"""" Plugins

call plug#begin()
"Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
"Plug 'tpope/vim-fugitive'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ajh17/vimcompletesme'
Plug 'sheerun/vim-polyglot'
Plug 'rstacruz/vim-closer'

Plug 'SirVer/ultisnips'
Plug 'ap/vim-css-color'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mcchrish/nnn.vim', { 'branch': 'rewrite' }
"Plug 'mhinz/vim-startify'
Plug 'mxw/vim-jsx'
Plug 'pR0Ps/molokai-dark'
Plug 'pangloss/vim-javascript'
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
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'zxqfl/tabnine-vim'
call plug#end()

so ~/.vim/plugins.vim

runtime macros/matchit.vim

let mapleader=" "

"fzf
let $FZF_DEFAULT_OPTS='--reverse'
"let g:fzf_layout = { 'window' : { 'width': 0.8, 'height': 0.8 } }

"""""" Competitive programming shorcuts
autocmd filetype cpp nnoremap <F8> :w <bar> ! g++ -std=c++17 -DLOCAL -Wall -g -O2 -Wconversion -Wshadow -Wextra % -o %:r && echo "Running..." && ./%:r <CR>
filetype plugin indent on    " required

autocmd filetype python nnoremap <F8> :w <bar> !python3 % <CR>

set showcmd
let g:UltiSnipsExpandTrigger = '<f5>' 


"Comandos de guardar
nmap <c-s> :w<cr>
imap <c-s> <Esc>:w<cr>

colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
"colorscheme molokai-dark
"let g:airline_theme='molokai'

set signcolumn=yes


hi diffAdded cterm=bold ctermbg=NONE ctermfg=NONE
hi diffRemoved cterm=bold ctermbg=NONE ctermfg=NONE

hi normal ctermbg=232 ctermfg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi cursorLineNr cterm=NONE ctermfg=DarkBlue
hi Pmenu ctermbg=236 guibg=darkgray guibg=#1c1c1c
hi signcolumn ctermbg=NONE guibg=NONE
hi TabLineFill cterm=NONE

" Startify
"
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'c': '~/.config/qtile' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ { 'x': '~/.xmonad/xmonad.hs' },
            \ { 'b': '~/.config/xmobar/primary.hs' },
            \ ]

" Floating window (neovim latest and vim with patch 8.2.191)

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif

hi LspErrorText ctermfg=9
hi LspWarningText ctermfg=214
hi LspInformationText ctermfg=21
hi LspInformationHighlight ctermbg=21 ctermfg=white
hi LspWarningHighlight ctermbg=94 ctermfg=white

nnoremap <Leader>t :sp<bar>term<cr><c-w>J:resize9<cr>
