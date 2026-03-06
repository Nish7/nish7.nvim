local macos_background_inflight = false
local macos_background_callbacks = {}

local function parse_macos_background(output)
  local normalized = (output or ''):gsub('%s+', ''):lower()
  if normalized == 'true' then
    return 'dark'
  end

  if normalized == 'false' then
    return 'light'
  end

  return nil
end

local function detect_macos_background(callback)
  if vim.fn.has 'macunix' == 0 then
    callback(nil)
    return
  end

  table.insert(macos_background_callbacks, callback)
  if macos_background_inflight then
    return
  end

  macos_background_inflight = true

  local function flush(result)
    macos_background_inflight = false

    local callbacks = macos_background_callbacks
    macos_background_callbacks = {}

    for _, cb in ipairs(callbacks) do
      cb(result)
    end
  end

  local cmd = {
    'osascript',
    '-e',
    'tell application "System Events" to tell appearance preferences to get dark mode',
  }

  if vim.system then
    vim.system(cmd, { text = true }, function(obj)
      local result = nil
      if obj.code == 0 then
        result = parse_macos_background(obj.stdout)
      end

      vim.schedule(function()
        flush(result)
      end)
    end)
    return
  end

  local stdout = {}
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        stdout = data
      end
    end,
    on_exit = function(_, code)
      local result = nil
      if code == 0 then
        result = parse_macos_background(table.concat(stdout, '\n'))
      end

      vim.schedule(function()
        flush(result)
      end)
    end,
  })
end

local function apply_rose_pine_overrides()
  vim.api.nvim_set_hl(0, 'Normal', { fg = '#dadada', bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'NormalNC', { fg = '#dadada', bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#1D2021' })

  vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#232a2d', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#232a2d', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2A2E2F' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#2A2E2F' })

  vim.api.nvim_set_hl(0, 'CmpItemAbbr', { bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'FloatTitle', { bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#232a2d', bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'MsgArea', { fg = '#dadada', bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#232a2d', bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#232a2d', bg = '#1D2021' })
  vim.api.nvim_set_hl(0, 'ZenBg', { bg = '#1D2021' })
end

local function set_theme(background)
  if background == vim.g.current_theme_background then
    return
  end

  vim.g.current_theme_background = background
  vim.o.background = background

  if background == 'light' then
    require('onedark').load()
    return
  end

  vim.cmd.colorscheme 'gruvbox'
  apply_rose_pine_overrides()
end

local function apply_theme_from_system()
  set_theme(vim.o.background)

  detect_macos_background(function(background)
    if background ~= nil then
      set_theme(background)
    end
  end)
end

return {
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
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        contrast = 'soft',
      }

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
