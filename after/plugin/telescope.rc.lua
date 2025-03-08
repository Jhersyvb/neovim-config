local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

-- Function to open a file in a given split mode
local function open_in_split(prompt_bufnr, split_cmd)
  local selected_entry = action_state.get_selected_entry()
  local filename = selected_entry.path or selected_entry.value -- Use 'value' for buffers
  local lnum = selected_entry.lnum or 1 -- Default to line 1 if not available

  if not filename then
    vim.notify("Error: Could not get filename", vim.log.levels.ERROR)
    return
  end

  actions.close(prompt_bufnr)
  vim.cmd(split_cmd .. " " .. filename)
  vim.api.nvim_win_set_cursor(0, { lnum, 0 }) -- Move cursor to the matched line
end

telescope.setup {
  defaults = {
    sorting_strategy = "descending",
    prompt_prefix = "   ",
    mappings = {
      i = {
        ["<C-v>"] = function(prompt_bufnr) open_in_split(prompt_bufnr, "belowright vsplit") end,
        ["<C-b>"] = function(prompt_bufnr) open_in_split(prompt_bufnr, "botright vsplit") end,
        ["<C-x>"] = function(prompt_bufnr) open_in_split(prompt_bufnr, "belowright split") end,
        ["<C-z>"] = function(prompt_bufnr) open_in_split(prompt_bufnr, "botright split") end,
      },
      n = {
        ["q"] = actions.close,
        ["<C-v>"] = function(prompt_bufnr) open_in_split(prompt_bufnr, "belowright vsplit") end,
        ["<C-b>"] = function(prompt_bufnr) open_in_split(prompt_bufnr, "botright vsplit") end,
        ["<C-x>"] = function(prompt_bufnr) open_in_split(prompt_bufnr, "belowright split") end,
        ["<C-z>"] = function(prompt_bufnr) open_in_split(prompt_bufnr, "botright split") end,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hidden = true,
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
      sort_mru = true,
      ignore_current_buffer = true,
      mappings = {
        i = {
          ["<C-w>"] = "delete_buffer",
        },
        n = {
          ["<C-w>"] = "delete_buffer",
        },
      },
    },
    git_status = {
      theme = "ivy",
    },
  },
}

telescope.load_extension("file_browser")

vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end)
vim.keymap.set('n', '<leader>fg', function() builtin.live_grep() end)
vim.keymap.set('n', '<leader>fb', function() builtin.buffers() end)
vim.keymap.set('n', '<leader>fh', function() builtin.help_tags() end)
vim.keymap.set('n', '<leader>fr', function() builtin.resume() end)
vim.keymap.set('n', '<leader>fd', function() builtin.diagnostics() end)
vim.keymap.set('n', '<leader>gf', function() builtin.git_files() end)
vim.keymap.set('n', '<leader>gs', function() builtin.git_status() end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 }
  })
end)
