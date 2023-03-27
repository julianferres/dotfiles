require("plugins")

-- General editor settings --
vim.opt.mouse = "a" -- enable mouse support (might not work well on Mac OS X)
vim.opt.encoding = "utf-8" -- set encoding to utf-8
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.wildmenu = true -- visual autocomplete for command menu
vim.opt.lazyredraw = true -- redraw screen only when we need to
vim.opt.showmatch = true -- highlight matching parentheses / brackets [{()}]
vim.opt.visualbell = false -- disable visual bell
vim.opt.signcolumn = "no" -- show line number on statusline
vim.opt.wrap = false -- avoid wrapping lines
vim.opt.swapfile = false -- disable swapfile
vim.opt.ttyfast = true -- Avoid Ctrl-S freezing the terminal
-- persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
-- Leader keys
vim.g.mapleader = " " -- set leader key to space
vim.g.localleader = "," -- set localleader to comma

-- Key mappings -- 
vim.keymap.set("n", "j", "gj") -- move by visual line (useful for wrapped lines)
vim.keymap.set("n", "k", "gk") -- move by visual line
vim.keymap.set("n", "<down>", "gj") -- move by visual line
vim.keymap.set("n", "<up>", "gk") -- move by visual line
-- Select all file and copy to clipboard
vim.keymap.set("n", "gA", "m'ggVG\"+y''")
-- Move selected lines up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
-- Save
vim.keymap.set({"n", "i"}, "<C-s>", "<Esc>:w<CR>")
-- Unset last search pattern
vim.keymap.set("n", "<CR>", ":noh<CR><CR>")
-- Jump between buffers
vim.keymap.set("n", "<leader><leader>", "<C-^>")
-- Close current buffer
vim.keymap.set("n", "<leader>q", "<Esc>:bd<CR>")
-- Toggle wrap
vim.keymap.set("n", "<A-z>", "<Esc>:set wrap!<CR>")
-- Join lines without space between
vim.keymap.set("n", "J", "gJ")

-- Tabs and indents
vim.opt.tabstop = 4 -- number of spaces that a <TAB> counts for
vim.opt.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4 -- backspace after pressing <TAB> will remove up to this many spaces
vim.opt.expandtab = true -- convert <TAB> key-presses to spaces
-- Indentation settings
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.smartindent = true -- even better autoindent (e.g. add indent after '{')
vim.opt.smarttab = true -- useful when softtabstop and shiftwidth are different
-- Search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- start case-insensitive, as soon as a capital letter appears, switch to case-sensitive
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = true -- highlight matches
-- Misc settings
vim.opt.cursorline = true -- highlight current line
vim.opt.background = "dark" -- configure Vim to use darker colors
vim.opt.autoread = true -- autoreload the file in Vim if it has been changed outside of Vim
vim.opt.clipboard = "unnamedplus" -- link global clipboard
-- Competitive programming compile autocmd
vim.api.nvim_create_autocmd("FileType", { pattern = "cpp", 
command = "autocmd filetype cpp nnoremap <F9> :w <bar> ! g++ -std=c++17 -DLOCAL -Wall -g -O2 -Wconversion -Wshadow -Wextra % -o %:r<CR>"})

-- Colorscheme --
vim.cmd("colorscheme tokyonight-moon")
require('lualine').setup {
    options = { theme = 'auto' },
}

-- Plugin configs and mapppings --

-- NERDTree and Undotree
vim.keymap.set("n", "<F6>", ":NERDTreeToggle<CR>") -- toggle NERDTree
vim.keymap.set("n", "<F10>", ":UndotreeToggle<CR>") -- toggle Undotree
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-t>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set("n", "<leader>e", builtin.diagnostics, {})
-- FTerm
require'FTerm'.setup({
    cmd = 'pwsh -nologo',
    border = 'double',
})
vim.keymap.set('n', '<F12>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<F12>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
-- LSP zero
local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.preset('recommended')
lsp.setup_nvim_cmp({
  mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = vim.NIL,
      ['<S-Tab>'] = vim.NIL,
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
            reason = cmp.ContextReason.Auto,
          }), {"i", "c"}),
  })
})
lsp.setup()
vim.diagnostic.config({ -- Inline errors
  virtual_text = true
})
-- Mason 'marketplace' for lsp servers
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})



