-- plugins/kiwi.lua:
return {
  { 'tools-life/taskwiki' },
  {
    'serenevoid/kiwi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      {
        name = 'work',
        path = '/home/bastian/vaults/work',
      },
      {
        name = 'personal',
        path = '/home/bastian/vaults/personal',
      },
    },
    keys = {
      { '<leader>ww', ':lua require("kiwi").open_wiki_index()<cr>',           desc = 'Open Wiki index' },
      { '<leader>wp', ':lua require("kiwi").open_wiki_index("personal")<cr>', desc = 'Open index of personal wiki' },
      { 'T',          ':lua require("kiwi").todo.toggle()<cr>',               desc = 'Toggle Markdown Task' },
      { '<leader>np', ':lua require("kiwi").open_link()<CR>',                 desc = 'Open Kiwi Link' },
      { '<leader>nl', ':let @/="\\\\[.\\\\{-}\\\\]"<CR>nl',                   desc = 'Move to Next Kiwi Link' },
    },
    lazy = true,
  },
}
