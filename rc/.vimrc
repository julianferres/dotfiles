" ================== General settings =====================
set mouse=a                 " enable mouse support (might not work well on Mac OS X)
set encoding=utf-8          " correct encoding
set number relativenumber   " relative number for lines, and absolute number for current line
set wildmenu                " visual autocomplete for command menu
set lazyredraw              " redraw screen only when we need to
set showmatch               " highlight matching parentheses / brackets [{()}]
set laststatus=2            " always show statusline (even with only single window)
set ruler                   " show line and column number of the cursor on right side of statusline
set visualbell 
set signcolumn=number       " show line number on statusline

" Permanent undo
set undodir=~/.vim/undodir
set undofile

" Frees Ctrl-S and Ctrl-q (if not it freezes the terminal)
silent !stty -ixon
autocmd VimLeave * silent !stty ixon

" Leader map
let mapleader=" "

" ================== Plugins =========================

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' } 
"Plug 'github/copilot.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/suda.vim'
Plug 'cplaursen/vim-isabelle'
Plug 'machakann/vim-highlightedyank'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'preservim/nerdcommenter'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
call plug#end()


" ================== Key Bindings =========================

" Move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk
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
nmap <leader><leader> <c-^>
nmap <Leader>x <Esc>:wq<cr>
nnoremap <Leader>, :set invlist<cr>

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
map <C-p> :Files<CR>
map <C-t> :Rg<CR>
"let g:fzf_action = { 'enter': 'tab split' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.5, 'relative': v:true, 'yoffset': 1.0 } }
let $FZF_DEFAULT_OPTS='--reverse'
filetype plugin indent on    " required

" ==== NERDTree ====
nmap <F6> :NERDTreeToggle<CR>

" ==== Undotree ====
nnoremap <F7> :UndotreeToggle<CR>

" ==== easymotion ==== 
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Leader>s <Plug>(easymotion-s2)
map <Leader>w <Plug>(easymotion-w)

"hi signcolumn ctermbg=235
"let g:gruvbox_contrast_dark = 'hard'
colorscheme dracula

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

hi Normal ctermbg=NONE guibg=#000000
hi LineNr ctermbg=NONE guibg=#000000

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

" make tab traverse suggestion options and enter not to jump line
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <c-space> to trigger completion in neovim with ctrl+space
inoremap <silent><expr> <c-space> coc#refresh()

" ==== floaterm ==== 
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_height = 0.5
let g:floaterm_width = 1.0
let g:floaterm_wintype = 'float'
let g:floaterm_position = 'bottom'

" ==== lsp configs ====
" LSP config commands
lua << EOF
local servers = { 'pyright', 'clangd', 'rust_analyzer', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
EOF


" ==== Startify ====
let g:startify_custom_header = [
      \  '                                  __                  ',
      \  '     ___     ___    ___   __  __ /\_\    ___ ___      ',
      \  '    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\    ',
      \  '   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \   ',
      \  '   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\  ',
      \  '    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/  ',
      \ ]



" Disable Arrow keys in Normal mode
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Disable Arrow keys in Insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" ==== Competitive Programming ====
nnoremap <Leader>cp :r ~/CP/templates/problem/main.cpp

autocmd filetype cpp nnoremap <F5> :w <bar> !cf run %:r <CR>
