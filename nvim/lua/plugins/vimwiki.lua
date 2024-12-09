return {
  { 'tools-life/taskwiki' },
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/vaults/work',
          syntax = 'markdown',
          ext = '.md',
        },
      }
      -- vimwiki
      vim.keymap.set('n', '<leader>nl', '<Plug>VimwikiNextLink', opts)
      vim.keymap.set('n', '<leader>pl', '<Plug>VimwikiPrevLink', opts)
    end,
  },
}
