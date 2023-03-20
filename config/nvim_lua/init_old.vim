" ================== General settings =====================
set mouse=a                 " enable mouse support (might not work well on Mac OS X)
set encoding=utf-8          " correct encoding
set number relativenumber   " relative number for lines, and absolute number for current line
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw screen only when we need to
set showmatch               " highlight matching parentheses / brackets [{()}]
set laststatus=2            " always show statusline (even with only single window)
set ruler                   " show line and column number of the cursor on right side of statusline
set novisualbell 
set signcolumn=number       " show line number on statusline
set nowrap                  " Avoid wrapping lines
set noswapfile

" Permanent undo
set undodir=~/.vim/undodir
set undofile

" Frees Ctrl-S and Ctrl-q (if not it freezes the terminal)
silent !stty -ixon
autocmd VimLeave * silent !stty ixon

" Leader map
let mapleader=" "
let maplocalleader = ","

" ================== Plugins =========================

call plug#begin('~/.vim/plugged')
" Sytax and Autocomplete
"""Plug 'github/copilot.vim'
Plug 'ap/vim-css-color'
Plug 'jxnblk/vim-mdx-js'
Plug 'cplaursen/vim-isabelle'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
" UI
Plug 'dracula/vim', { 'as': 'dracula' } 
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Latex
Plug 'lervag/vimtex'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Utilities
"Plug 'SirVer/ultisnips'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/suda.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mbbill/undotree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'preservim/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

"  Plug 'voldikss/vim-floaterm'
"  Plug 'akinsho/toggleterm.nvim', {'tag' : 'v1.*'}
Plug 'numToStr/FTerm.nvim'

Plug 'searleser97/cpbooster.vim'

call plug#end()


" ================== Key Bindings =========================

" Move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk
nmap <up> gk
nmap <down> gj
nmap E ge
map H ^
map L $
    
" Ctrl-A Ctrl-C Ctrl-V
map gA m'ggVG"+y''

" Move lines
xnoremap <C-k> :move '<-2<CR>gv=gv
xnoremap <C-j> :move '>+1<CR>gv=gv

" Save commands
nmap <c-s> :w<cr>
imap <c-s> <Esc>:w<cr>

"This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR><CR>

" Jump between buffers
"nmap <leader><leader> <c-^>
nmap <Leader>q <Esc>:bd<cr>
nnoremap <Leader>, :set invlist<cr>
nmap <A-z> <Esc>:set wrap!<cr>


" use filetype-based syntax highlighting, ftplugins, and indentation
syntax enable
filetype plugin indent on
syntax on

"""" Tab settings

set tabstop=4           " width that a <TAB> character displays as
set expandtab           " convert <TAB> key-presses to spaces
set shiftwidth=4        " number of spaces to use for each step of (auto)indent
set softtabstop=4       " backspace after pressing <TAB> will remove up to this many spaces

set autoindent          " copy indent from current line when starting a new line
set smartindent         " even better autoindent (e.g. add indent after '{')
set smarttab

"""" Search settings
set ignorecase
set smartcase           " start case-insensitive, as soon as a capital letter appears, switch to case-sensitive
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

"""" Miscellaneous settings that might be worth enabling
set cursorline               " highlight current line
set background=dark          " configure Vim to use darker colors
set autoread                 " autoreload the file in Vim if it has been changed outside of Vim
set clipboard=unnamedplus    " afaik, this links global clipboard


"set nocompatible              " be iMproved, required
"filetype off                  " required

" ==== fzf ==== 
"map <C-p> :Files<CR>
"map <C-t> :Rg<CR>
"let g:fzf_action = { 'enter': 'tab split' }
"let g:fzf_preview_window = ['right:50%', 'ctrl-/']
"let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.5, 'relative': v:true, 'yoffset': 1.0 } }
"let $FZF_DEFAULT_OPTS='--reverse'
"filetype plugin indent on    " required

" ==== NERDTree ====
nmap <F6> :NERDTreeToggle<CR>
" ==== Undotree ====
nnoremap <F10> :UndotreeToggle<CR>

" ==== easymotion ==== 
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Leader>s <Plug>(easymotion-s2)
map <Leader>w <Plug>(easymotion-w)

" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-t> <cmd>Telescope live_grep<cr>
nnoremap <leader><leader> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


"hi signcolumn ctermbg=235
"let g:gruvbox_contrast_dark = 'hard'
colorscheme dracula
"colorscheme gruvbox
"let g:gruvbox_contrast_dark = 'hard'

" ==== Airline ====
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" ==== Highlight yank ====
let g:highlightedyank_highlight_duration = 500

"let g:vim_monokai_tasty_italic = 1
"colorscheme vim-monokai-tasty
"let g:airline_theme='monokai_tasty'

"hi Normal ctermbg=NONE guibg=#000000
"hi LineNr ctermbg=NONE guibg=#000000
set termguicolors

""" ==== coc.nvim ====
" coc settings and mappings
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Use <tab> and <S-tab> to navigate completion list:
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

"Use <c-space> to trigger completion:
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"Use <CR> to confirm completion, use:
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <silent> <F2> <Plug>(coc-rename)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>cl  <Plug>(coc-codelens-action)

" ==== floaterm ==== 
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_height = 0.4
let g:floaterm_width = 1.0
let g:floaterm_wintype = 'float'
let g:floaterm_position = 'bottom'

" ==== Compile latex ====
"autocmd filetype tex nnoremap <F9> :w <bar>!latexmk -interaction=nonstopmode -pdf >/dev/null 2>&1 <cr><cr>
autocmd filetype tex nnoremap <F9> :VimtexCompile<cr>
let g:vimtex_view_general_viewer = 'evince'

autocmd filetype markdown nnoremap <F9> :CocCommand markdown-preview-enhanced.openPreview<cr>

autocmd filetype cpp nnoremap <F8> :w <bar> ! g++ -std=c++17 -DLOCAL -Wall -g -O2 -Wconversion -Wshadow -Wextra % -o %:r<CR>

