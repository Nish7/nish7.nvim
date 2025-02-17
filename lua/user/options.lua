-- Enable relative line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- disable netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- Set tabs to 4 spaces
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Enable auto indenting and set it to spaces
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

-- Scroll
vim.opt.mousescroll = 'ver:1,hor:2'

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

-- Enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Disable text wrap
vim.opt.wrap = true

-- Set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable swap fils
vim.o.swapfile = false

-- Enable mouse mode
vim.opt.mouse = 'a'

-- remove the end of buffer squigly char
vim.opt.fillchars = { eob = ' ' }

-- Enable ignorecase + smartcase for better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease updatetime to 200ms
vim.opt.updatetime = 50

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { 'menuone', 'noselect' }

-- Enable persistent undo history
vim.opt.undofile = true

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = 'yes'

-- Enable access to System Clipboard
vim.opt.clipboard = 'unnamed,unnamedplus'

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 8

-- Place a column line
-- vim.opt.colorcolumn = '80'

vim.opt.guicursor = {
  'n-v-c:block', -- Normal, visual, command-line: block cursor
  'i-ci-ve:block', -- Insert, command-line insert, visual-exclude: block cursor
  'r-cr:block', -- Replace, command-line replace: block cursor
  'o:block', -- Operator-pending: block cursor
  'a:block', -- All modes: block cursor
  'sm:block', -- Showmatch: block cursor
}
