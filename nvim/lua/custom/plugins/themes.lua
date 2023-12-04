-- Dracula Theme
return {
  'Mofiqul/dracula.nvim',
    priority = 500,
    config = function()
      vim.cmd.colorscheme 'dracula'
    end,
}

-- Tokyo Night
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--     config = function()
--       vim.cmd.colorscheme 'tokyonight-moon'

