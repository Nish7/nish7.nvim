return {
  {
    'Everblush/nvim',
    name = 'everblush',
    config = function() end,
  },

  {
    'catppuccin/nvim',
    config = function()
      require('catppuccin').setup {
        integrations = {
          cmp = true,
          gitsigns = true,
          harpoon = true,
          illuminate = true,
          indent_blankline = {
            enabled = false,
            scope_color = 'sapphire',
            colored_indent_levels = false,
          },
          mason = true,
          native_lsp = { enabled = true },
          notify = true,
          nvimtree = true,
          neotree = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
        },
      }
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      vim.cmd.colorscheme 'rose-pine'

      vim.api.nvim_set_hl(0, 'Normal', { fg = '#dadada', bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'NormalNC', { fg = '#dadada', bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbr', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'FloatTitle', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#232a2d', bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#232a2d', bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#232a2d', bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#171717' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#171717' })
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'MsgArea', { fg = '#dadada', bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#232a2d', bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#232a2d', bg = '#0e0e0e' })
      vim.api.nvim_set_hl(0, 'ZenBg', { bg = '#0e0e0e' })
    end,
  },
}
