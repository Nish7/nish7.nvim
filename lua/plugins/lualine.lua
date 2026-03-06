return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
      local harpoon = require 'harpoon.mark'

      local function clear_statusline_bg()
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })

        local lualine_hls = vim.fn.getcompletion('lualine_', 'highlight')
        for _, hl in ipairs(lualine_hls) do
          vim.cmd('highlight ' .. hl .. ' guibg=NONE ctermbg=NONE')
        end
      end

      local function harpoon_component()
        local total_marks = harpoon.get_length()

        if total_marks == 0 then
          return ''
        end

        local current_mark = '—'

        local mark_idx = harpoon.get_current_index()
        if mark_idx ~= nil then
          current_mark = tostring(mark_idx)
        end

        return string.format('󱡅 %s/%d', current_mark, total_marks)
      end

      require('lualine').setup {
        options = {
          theme = 'auto',
          globalstatus = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {},
          lualine_b = {
            { 'branch', icon = '' },
            harpoon_component,
            'diff',
            'diagnostics',
          },
          lualine_c = {
            { 'filename', path = 1 },
          },
          lualine_x = {
            'filetype',
          },
        },
      }

      clear_statusline_bg()
      local group = vim.api.nvim_create_augroup('lualine_transparent_bg', { clear = true })
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = group,
        callback = clear_statusline_bg,
      })
    end,
  },
}
