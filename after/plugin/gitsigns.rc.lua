local status, nvim_gitsigns = pcall(require, "gitsigns")
if (not status) then return end

nvim_gitsigns.setup()
