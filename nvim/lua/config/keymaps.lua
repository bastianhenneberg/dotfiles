-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Local Maps
-- Press 'U' for redo

-- Which Keymaps
local wk = require("which-key")
wk.register({
  ["<leader>i"] = {
    function()
      require("oil").toggle_float()
    end,
    "Open Oil.nvim in Float",
  },
  ["U"] = {
    "<C-r>",
    "Redo function",
  },
})
