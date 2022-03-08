set mouse=a             " enable mouse support (might not work well on Mac OS X)
set encoding=utf-8
set number relativenumber
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw screen only when we need to
set showmatch           " highlight matching parentheses / brackets [{()}]
set laststatus=2        " always show statusline (even with only single window)
set ruler               " show line and column number of the cursor on right side of statusline
set visualbell 
set signcolumn=number  " show line number on statusline

"Permanent undo
set undodir=~/.vim/undodir
set undofile

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
map <C-p> :Files<CR>
map <C-t> :Rg<CR>
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

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
"This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR><CR>

"""" Miscellaneous settings that might be worth enabling

set cursorline   " highlight current line
set background=dark    " configure Vim to use darker colors
set autoread           " autoreload the file in Vim if it has been changed outside of Vim
set clipboard=unnamedplus

"""" Plugins

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' } 
Plug 'easymotion/vim-easymotion'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
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


set nocompatible              " be iMproved, required
filetype off                  " required
runtime macros/matchit.vim

" Atajos para easymotion
let mapleader=" "
map <Leader>s <Plug>(easymotion-s2)
map <Leader>w <Plug>(easymotion-w)

" Jump between buffers
map <Leader>p <c-^>
map <Leader>x <Esc>:wq<cr>


map <Leader>rp :so %<cr>:PlugInstall<cr>
map <Leader>rr :so %<cr>


"fzf
let $FZF_DEFAULT_OPTS='--reverse'
filetype plugin indent on    " required

"Comandos de guardar
nmap <c-s> :w<cr>
imap <c-s> <Esc>:w<cr>

"hi signcolumn ctermbg=235
"let g:gruvbox_contrast_dark = 'hard'
colorscheme dracula

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

let g:highlightedyank_highlight_duration = 500

"let g:vim_monokai_tasty_italic = 1
"colorscheme vim-monokai-tasty

"let g:airline_theme='monokai_tasty'

hi Normal ctermbg=NONE guibg=#000000
hi LineNr ctermbg=NONE guibg=#000000

" Comandos para configurar los lsp
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


""" coc settings and mappings
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:startify_custom_header = [
      \  '                                  __                  ',
      \  '     ___     ___    ___   __  __ /\_\    ___ ___      ',
      \  '    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\    ',
      \  '   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \   ',
      \  '   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\  ',
      \  '    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/  ',
      \ ]


nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

