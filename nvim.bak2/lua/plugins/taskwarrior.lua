return {
  {
    'duckdm/neowarrior.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      --- Optional but recommended for nicer inputs
      --- 'folke/noice.nvim',
    },
    config = function()
      local nw = require 'neowarrior'
      local home = vim.env.HOME
      nw.setup {
        report = 'next',
        filter = '\\(due.before:2d or due: \\)',
        dir_setup = {
          {
            dir = home .. '/dev/nvim/neowarrior.nvim',
            filter = 'project:neowarrior',
            mode = 'tree',
            expanded = true,
          },
        },
      }
      vim.keymap.set('n', '<leader>tr', function()
        nw.open_right()
      end, { desc = 'Open nwarrior on the right side' })
      vim.keymap.set('n', '<leader>tt', function()
        nw.focus()
      end, { desc = 'Focus nwarrior' })
    end,
  },

  {
    'huantrinh1802/m_taskwarrior_d.nvim',
    version = '*',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      -- Require
      require('m_taskwarrior_d').setup()
      -- Optional
      vim.api.nvim_set_keymap('n', '<leader>te', '<cmd>TWEditTask<cr>', { desc = 'TaskWarrior Edit', noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tv', '<cmd>TWView<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tu', '<cmd>TWUpdateCurrent<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>TWSyncTasks<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<c-space>', '<cmd>TWToggle<cr>', { silent = true })
      -- Be caution: it may be slow to open large files, because it scan the whole buffer
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('TWTask', { clear = true }),
        pattern = '*.md,*.markdown', -- Pattern to match Markdown files
        callback = function()
          vim.cmd 'TWSyncTasks'
        end,
      })
    end,
  },
}
