vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
-- vim.o.clipboard = 'unnamedplus'

-- Fix copy and paste in WSL (Windows Subsystem for Linux)
vim.g.clipboard = {
  name = "win32yank", -- Use win32yank for clipboard operations
  copy = {
    ["+"] = "win32yank.exe -i --crlf", -- Command to copy to the system clipboard
    ["*"] = "win32yank.exe -i --crlf", -- Command to copy to the primary clipboard
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf", -- Command to paste from the system clipboard
    ["*"] = "win32yank.exe -o --lf", -- Command to paste from the primary clipboard
  },
  cache_enabled = false, -- Disable clipboard caching
}
