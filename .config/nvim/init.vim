set mouse=a             " enable mouse support (might not work well on Mac OS X)
set number relativenumber
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw screen only when we need to
set showmatch           " highlight matching parentheses / brackets [{()}]
set laststatus=2        " always show statusline (even with only single window)
set ruler               " show line and column number of the cursor on right side of statusline
set visualbell 
set rtp+=~/.fzf
source ~/.fzf/plugin/fzf.vim

set noeb
set novb

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
set hlsearch            " highlight matches
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

"""" Miscellaneous settings that might be worth enabling

set cursorline   " highlight current line
set background=dark    " configure Vim to use darker colors
set autoread           " autoreload the file in Vim if it has been changed outside of Vim
set clipboard=unnamedplus

"""" Plugins

call plug#begin()
"Plug 'morhetz/gruvbox'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-startify'
"Plug 'jiangmiao/auto-pairs'
Plug 'mcchrish/nnn.vim', { 'branch': 'rewrite' }
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'pR0Ps/molokai-dark'
"Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mxw/vim-jsx'
Plug 'preservim/nerdcommenter'
Plug 'pangloss/vim-javascript'
Plug 'zxqfl/tabnine-vim'
Plug 'skywind3000/asyncrun.vim'
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

so ~/.vim/plugins.vim

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
autocmd filetype cpp nnoremap <F8> :w <bar> AsyncRun g++ -std=c++17 -DLOCAL -Wall -g -O2 -Wconversion -Wshadow -Wextra % -o %:r && ./%:r <CR>
filetype plugin indent on    " required

autocmd filetype python nnoremap <F8> :w <bar> AsyncRun python3 % <CR>

set showcmd
let g:ycm_show_diagnostics_ui = 0
let g:syntastic_check_on_write = 1
let g:syntastic_warning_symbol = '·'
let g:syntastic_error_symbol = '>'
let g:syntastic_enable_signs=1
let g:coc_disable_startup_warning = 1
let g:UltiSnipsExpandTrigger = '<f5>' 

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"Async
let g:asyncrun_open=10

"Comandos de guardar
nmap <c-s> :w<cr>
imap <c-s> <Esc>:w<cr>

nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gl :Gpull<CR>

"colorscheme gruvbox
"let g:gruvbox_contrast_dark='hard'
colorscheme molokai-dark
let g:airline_theme='molokai'

set signcolumn=yes


hi diffAdded cterm=bold ctermbg=NONE ctermfg=NONE
hi diffRemoved cterm=bold ctermbg=NONE ctermfg=NONE

hi LineNr ctermbg=NONE guibg=NONE
hi cursorLineNr cterm=NONE ctermfg=DarkBlue
hi Pmenu ctermbg=236 guibg=darkgray
hi signcolumn ctermbg=NONE

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
            \ ]

" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }
