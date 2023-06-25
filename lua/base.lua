local opt = vim.opt

-- Clipboard 
opt.clipboard = 'unnamedplus'

-- Tabs
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

-- Split
opt.splitright = true
opt.splitbelow = true

-- Additional
opt.number = true
opt.cursorline = true
vim.cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]
