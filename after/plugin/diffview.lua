-- Lua
local actions = require("diffview.actions")

local function get_diffview_layout()
  local file = "/mnt/c/Users/Jhersy/.wezterm_size"
  local f = io.open(file, "r")

  if f then
    local pixel_size = f:read("*all")
    f:close()

    local width, height = pixel_size:match("(%d+),(%d+)")
    width = tonumber(width)
    height = tonumber(height)

    if width and height then
      -- print("Detected Pixels - Width: " .. width .. ", Height: " .. height) -- Debugging output
      return width < height and "vertical" or "horizontal"
    end
  end

  -- print("Failed to detect pixel size, defaulting to horizontal") -- Debugging output
  return "horizontal"
end

require("diffview").setup({
  view = {
    default = {
      layout = "diff2_" .. get_diffview_layout(),
    },
    merge_tool = {
      layout = "diff3_" .. get_diffview_layout(),
    },
    file_history = {
      layout = "diff2_" .. get_diffview_layout(),
    },
  },
})

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    -- Add a small delay (500ms) before reading the file
    vim.defer_fn(function()
      local current_layout = get_diffview_layout()

      require("diffview").setup({
        view = {
          default = {
            layout = "diff2_" .. current_layout,
          },
          merge_tool = {
            layout = "diff3_" .. current_layout,
          },
          file_history = {
            layout = "diff2_" .. current_layout,
          },
        }
        ,
      })
    end, 500) -- 500ms delay
  end,
})
