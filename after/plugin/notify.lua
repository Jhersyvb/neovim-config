require("notify").setup({
  render = "wrapped-compact", -- use compact rendering
  max_width = function()
    return math.floor(vim.o.columns * 0.3) -- 30% of editor width
  end,
  max_height = function()
    return math.floor(vim.o.lines * 0.2) -- 20% of editor height
  end,
  minimum_width = 30, -- minimum width for wrapping
})
