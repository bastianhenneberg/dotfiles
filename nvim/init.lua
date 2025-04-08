-- If is in VSCode
if vim.g.vscode then
  -- Load custom modules
  for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath 'config' .. '/lua/user_functions', [[v:val =~ '\.lua$']])) do
    require('user_functions.' .. file:gsub('%.lua$', ''))
  end

  -- Set up the Lazy plugin manager
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
      error('Error cloning lazy.nvim:\n' .. out)
    end
  end
  vim.opt.rtp:prepend(lazypath)

  -- Set up plugins
  require('lazy').setup {
    -- require 'plugins.lualine',
    require 'plugins.flash',
    require 'plugins.comment',
  }
else
  require 'core.options' -- Load general options
  require 'core.keymaps' -- Load general keymaps
  require 'core.snippets' -- Custom code snippets

  -- Load custom modules
  for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath 'config' .. '/lua/user_functions', [[v:val =~ '\.lua$']])) do
    require('user_functions.' .. file:gsub('%.lua$', ''))
  end

  -- Set up the Lazy plugin manager
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
      error('Error cloning lazy.nvim:\n' .. out)
    end
  end
  vim.opt.rtp:prepend(lazypath)

  -- Set up plugins
  require('lazy').setup {
    require 'plugins.neotree',
    --  require 'plugins.colortheme',
    require 'plugins.snacks',
    require 'plugins.rust',
    require 'plugins.session',
    require 'plugins.bufferline',
    require 'plugins.which-key',
    require 'plugins.cinnamon',
    require 'plugins.harpoon',
    require 'plugins.markdown',
    require 'plugins.zen-mode',
    require 'plugins.ufo',
    require 'plugins.lualine',
    require 'plugins.treesitter',
    require 'plugins.telescope',
    require 'plugins.lsp',
    require 'plugins.autocompletion',
    require 'plugins.none-ls',
    require 'plugins.gitsigns',
    require 'plugins.twilight',
    require 'plugins.flash',
    --  require 'plugins.alpha',
    require 'plugins.indent-blankline',
    require 'plugins.misc',
    require 'plugins.comment',
    require 'plugins.noice',
    require 'plugins.catppuccin',
    require 'plugins.laravel',
    require 'plugins.blade-nav',
    require 'plugins.taskwarrior',
    require 'plugins.tailwind-fold',
    require 'plugins.obsidian',
    require 'plugins.markdown-preview',
    require 'plugins.render-markdown',
    require 'plugins.vimwiki',
    require 'plugins.orgmode',
  }

  -- The line beneath this is called `modeline`. See `:help modeline`
  -- vim: ts=2 sts=2 sw=2 et
end
