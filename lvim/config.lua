-- Read the docs: https://www.lunarvim.org/docs/configuration
--
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
-- Relative Line Numbers
vim.wo.relativenumber = true

lvim.colorscheme = "dracula"
lvim.builtin.lualine.options.theme = "dracula-nvim"


-- Keymaps
lvim.keys.normal_mode["<leader>xx"] = ":set conceallevel=0<CR>"
lvim.keys.normal_mode["<leader>xt"] = ":set conceallevel=2<CR>"

lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

vim.opt.conceallevel = 2
lvim.builtin.treesitter.rainbow.enable = true

-- HTML
require('lspconfig').html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'php', 'blade'}
})

-- Emmet
require('lspconfig').emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'blade', 'php'}
})


-- Astro
-- require('lspconfig').astro.setup { init_options = { on_attach = on_attach, capabilities = capabilities, configuration = {}, typescript = { serverPath = vim.fs.normalize '~/.nvm/versions/node/v20.9.0/lib/node_modules/typescript/lib/tsserverlibrary.js', }, }, }

-- Plugins
lvim.plugins = {
  {
    "Mofiqul/dracula.nvim",
  },
  -- Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "python" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  -- Todo Comments Folke
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  -- Trouble Folke
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- Rainbow Brackets
  {
    "HiPhish/nvim-ts-rainbow2",
  },
  -- Autotag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- MiniMap Code-Minimap must be installed yay -S code-minimap
  {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
}
-- Dotted Coceal for class and TailwindCSS
-- should get bufnr from autocmd or something
-- conceal only accepts one character
-- thanks to u/Rafat913 for many suggestions and tips

local namespace = vim.api.nvim_create_namespace("class_conceal")
local group = vim.api.nvim_create_augroup("class_conceal", { clear = true })

local conceal_html_class = function(bufnr)
  local language_tree = vim.treesitter.get_parser(bufnr, "html")
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()

  local query = vim.treesitter.query.parse(
    "html",
    [[
    ((attribute
        (attribute_name) @att_name (#eq? @att_name "class")
        (quoted_attribute_value (attribute_value) @class_value) (#set! @class_value conceal "…")))
    ]]
  )   -- using single character for conceal thanks to u/Rafat913

  for _, captures, metadata in query:iter_matches(root, bufnr, root:start(), root:end_()) do
    local start_row, start_col, end_row, end_col = captures[2]:range()
    vim.api.nvim_buf_set_extmark(bufnr, namespace, start_row, start_col, {
      end_line = end_row,
      end_col = end_col,
      conceal = metadata[2].conceal,
    })
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
  group = group,
  pattern = "*.html",
  callback = function()
    conceal_html_class(vim.api.nvim_get_current_buf())
  end,
})
