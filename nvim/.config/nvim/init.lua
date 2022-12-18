vim.g.mapleader = ","

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable mouse in all modes
vim.opt.mouse = 'a'

-- Right mouse button extends a selection
vim.opt.mousemodel = 'extend'

-- Ignore case when searching, but match case when an uppercase letter is present
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Auto read when a file is changed from the outside and automatically save before commands like :next and :make
vim.opt.autoread = true
vim.opt.autowrite = true

-- Persistent undo
vim.opt.undofile = true

-- Show partial command in status line.
vim.opt.showcmd = true

-- Maximum number of open tabs
vim.opt.tabpagemax = 50

-- Always show the tabline, even with only one tab
vim.opt.showtabline = 2

-- Always show the spgn column
vim.opt.signcolumn = 'yes'

-- When opening a vertical split, put the new one on the right
vim.opt.splitright = true

-- Indentation
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Line breaks
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "...."

-- Colors
vim.opt.termguicolors = true

-- Exit insert terminal mode with <Esc>
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Enable <C-R> in terminal mode
vim.cmd [[:tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi']]

-- Always expect LaTeX code (instead of plain TeX code) within .tex files
vim.g.tex_flavor = "latex"


require('plugins')
require('autocommands')
require('telescope_config')
require('lsp_config')
require('cmp_config')
require('treesitter_config')
require('nvim_tree_config')
require('insert_config')
require('aerial_config')
require('luasnippets_config')
require('lualine_config')
