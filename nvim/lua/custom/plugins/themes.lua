-- Dracula Theme
return {
  'Mofiqul/dracula.nvim',
    priority = 500,
    config = function()
      vim.cmd.colorscheme 'dracula'
    end,
}
