return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

    local ftMap = {
      vim = 'indent',
      python = { 'indent' },
      git = '',
      markdown = { 'treesitter', 'indent' },
      php = { 'indent', 'treesitter' },
      lua = { 'indent', 'treesitter' },
      vimwiki = { 'treesitter', 'indent' },
    }
    -- Option 3: treesitter as a main provider instead
    -- (Note: the `nvim-treesitter` plugin is *not* needed.)
    -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
    -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
    require('ufo').setup {
      provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype]
      end,
    }
    --
  end,
}
