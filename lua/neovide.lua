local default_font = "VictorMono Nerd Font"
local default_size = 14

vim.g.neovide_transparency = 0.9

local function set_font(font, size)
  font = font or default_font
  size = size or default_size

  vim.o.guifont = string.format("%s:h%d", font, size)
end

set_font("JetBrainsMono Nerd Font", 12)
-- set_font()

-- https://github.com/neovim/neovim/issues/10223#issuecomment-521952122
vim.cmd([[
let g:clipboard = {
      \   'name': 'wayland-strip-carriage',
      \   'copy': {
      \      '+': 'wl-copy --foreground --type text/plain',
      \      '*': 'wl-copy --foreground --type text/plain --primary',
      \    },
      \   'paste': {
      \      '+': {-> systemlist('wl-paste --no-newline | tr -d "\r"')},
      \      '*': {-> systemlist('wl-paste --no-newline --primary | tr -d "\r"')},
      \   },
      \   'cache_enabled': 1,
      \ }
]])
