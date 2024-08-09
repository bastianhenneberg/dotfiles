-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
--

local opt = vim.opt

opt.conceallevel = 2
opt.concealcursor = ""

-- Enable relative line numbers
opt.nu = true
opt.rnu = true

-- Disable showing the mode below the statusline
opt.showmode = false

-- Set tabs to 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- Enable auto indenting and set it to spaces
opt.smartindent = true
opt.shiftwidth = 2

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
opt.breakindent = true

-- Enable incremental searching
opt.incsearch = true
opt.hlsearch = true

-- Disable text wrap
opt.wrap = false

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better splitting
opt.splitbelow = true
opt.splitright = true

-- Enable mouse mode
opt.mouse = "a"

-- Enable ignorecase + smartcase for better searching
opt.ignorecase = true
opt.smartcase = true

-- Decrease updatetime to 250ms
opt.updatetime = 250

-- Set completeopt to have a better completion experience
opt.completeopt = { "menuone", "noselect", "popup" }

-- Enable persistent undo history
opt.undofile = true

-- Enable 24-bit color
opt.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
opt.signcolumn = "yes"

-- Enable access to System Clipboard
opt.clipboard = "unnamed,unnamedplus"

-- Enable cursor line highlight
opt.cursorline = true

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Always keep 8 lines above/below cursor unless at start/end of file
opt.scrolloff = 8

-- Place a column line
-- vim.opt.colorcolumn = "80"

opt.guicursor = {
  "n-v-c:block", -- Normal, visual, command-line: block cursor
  "i-ci-ve:ver25", -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
  "r-cr:hor20", -- Replace, command-line replace: horizontal bar cursor with 20% height
  "o:hor50", -- Operator-pending: horizontal bar cursor with 50% height
  "a:blinkwait700-blinkoff400-blinkon250", -- All modes: blinking settings
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block cursor with specific blinking settings
}
