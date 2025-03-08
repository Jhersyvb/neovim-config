vim.cmd("autocmd!")

vim.cmd([[let g:python3_host_prog='/usr/bin/python3']])
vim.g.mapleader = " "
-- vim.cmd([[set mouse=a]])

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false -- No Wrap lines
vim.opt.title = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.backup = false
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.shell = 'zsh'
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.scrolloff = 4
vim.opt.inccommand = 'split'
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.list = true
vim.opt.listchars = "tab:\\ ,trail:-"
vim.opt.laststatus = 2

-- Undercurl
-- vim.cmd([[let &t_Cs = "\e[4:3m"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   pattern = '*',
--   command = "set nopaste"
-- })

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- https://github.com/mvllow/modes.nvim/issues/10#issuecomment-1072978755                                                                1
-- https://github.com/neovim/neovim/issues/12011#issuecomment-598716614
-- vim.api.nvim_create_autocmd("VimLeave", {
--   pattern = '*',
--   command = "set guicursor=a:ver25-blinkon1"
-- })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  callback = function()
    vim.b.saved_view = vim.fn.winsaveview()
  end
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*",
  callback = function()
    if vim.b.saved_view then
      vim.fn.winrestview(vim.b.saved_view)
    end
  end
})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})
