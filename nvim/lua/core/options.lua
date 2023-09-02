-- Leader Keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Spellcheck
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Other
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.cmd [[ set noswapfile ]]

-- Word Wrap
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

--Line numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorlineopt = {'number', 'line'}

-- line highlighting
vim.opt.list = true
