return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        php = { 'php' },
        astro = { 'prettier' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      notify_on_error = true,
      formatters = {
        php = {
          command = 'php-cs-fixer',
          args = {
            'fix',
            '$FILENAME',
            '--config=/your/path/to/config/file/[filename].php',
            '--allow-risky=yes', -- if you have risky stuff in config, if not you dont need it.
          },
          stdin = false,
        },
      },
    }
  end,
}
