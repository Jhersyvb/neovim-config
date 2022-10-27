vim.opt.termguicolors = true
require("bufferline").setup {
  options = {
    mode = "tabs",
    separator_style = "slant",
    show_close_icon = false,
  },
}

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
