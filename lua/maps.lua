-- https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/config/keymaps.lua
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- https://github.com/benfrain/neovim/blob/main/lua/mappings.lua
-- Here is a utility function that closes any floating windows when you press escape
local function close_floating()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

-- Do things without affecting the registers
-- keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
-- keymap.set("n", "dw", 'vb"_d')

-- Select all
-- keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })

keymap.set("n", "<Delete>", "<cmd>:w<CR>", { desc = "Save file" })

keymap.set("n", "<esc>", function()
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Navigate between windows
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Easier window switching with leader + Number
-- Creates mappings like this: km.set("n", "<Leader>2", "2<C-W>w", { desc = "Move to Window 2" })
for i = 1, 6 do
  local lhs = "<Leader>" .. i
  local rhs = i .. "<C-W>w"
  keymap.set("n", lhs, rhs, { desc = "Move to Window " .. i })
end

-- Move window
keymap.set("n", "sH", "<C-w>H")
keymap.set("n", "sK", "<C-w>K")
keymap.set("n", "sJ", "<C-w>J")
keymap.set("n", "sL", "<C-w>L")

keymap.set("n", "<Leader>J", "<C-W>J", { silent = true, desc = "Window Down" })
keymap.set("n", "<Leader>K", "<C-W>K", { silent = true, desc = "Window Up" })
keymap.set("n", "<Leader>L", "<C-W>L", { silent = true, desc = "Window Right" })
keymap.set("n", "<Leader>H", "<C-W>H", { silent = true, desc = "Window Left" })

-- Resize window
keymap.set("n", "<Leader><left>", "<C-w><")
keymap.set("n", "<Leader><right>", "<C-w>>")
keymap.set("n", "<Leader><up>", "<C-w>+")
keymap.set("n", "<Leader><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
