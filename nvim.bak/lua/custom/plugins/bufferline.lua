return {
  'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    how_buffer_icons = true,
  },

  config = function ()
    require('bufferline').setup {}
  end,
}
