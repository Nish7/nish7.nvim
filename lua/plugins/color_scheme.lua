local function detect_macos_background()
  if vim.fn.has('macunix') == 0 then
    return nil
  end

  local output = vim.fn.system {
    'osascript',
    '-e',
    'tell application "System Events" to tell appearance preferences to get dark mode',
  }

  if vim.v.shell_error ~= 0 then
    return nil
  end

  output = output:gsub('%s+', ''):lower()
  if output == 'true' then
    return 'dark'
  end

  if output == 'false' then
    return 'light'
  end

  return nil
end

local function apply_rose_pine_overrides()
  vim.api.nvim_set_hl(0, 'Normal', { fg = '#dadada', bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'NormalNC', { fg = '#dadada', bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#0e0e0e' })

  vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#232a2d', bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#232a2d', bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#171717' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#171717' })

  vim.api.nvim_set_hl(0, 'CmpItemAbbr', { bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'FloatTitle', { bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#232a2d', bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'MsgArea', { fg = '#dadada', bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#232a2d', bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#232a2d', bg = '#0e0e0e' })
  vim.api.nvim_set_hl(0, 'ZenBg', { bg = '#0e0e0e' })
end

local function apply_theme_from_system()
  local background = detect_macos_background() or vim.o.background
  vim.o.background = background

  if background == 'light' then
    require('onedark').load()
    return
  end

  vim.cmd.colorscheme 'rose-pine'
  apply_rose_pine_overrides()
end

return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'light',
      }
    end,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- require('bamboo').setup {
      --   -- optional configuration here
      -- }
      -- require('bamboo').load()
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      apply_theme_from_system()

      local group = vim.api.nvim_create_augroup('macos_theme_sync', { clear = true })
      vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained', 'UIEnter' }, {
        group = group,
        callback = function()
          pcall(apply_theme_from_system)
        end,
      })
    end,
  },
}
