return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    config = function()
      local harpoon = require 'harpoon.mark'
      local transparent_theme = require 'lualine.themes.auto'
      local has_navic, navic = pcall(require, 'nvim-navic')

      for _, mode in pairs(transparent_theme) do
        if type(mode) == 'table' then
          for _, section in pairs(mode) do
            if type(section) == 'table' then
              section.bg = 'NONE'
            end
          end
        end
      end

      local function clear_statusline_bg()
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })

        local lualine_hls = vim.fn.getcompletion('lualine_', 'highlight')
        for _, hl in ipairs(lualine_hls) do
          vim.cmd('highlight ' .. hl .. ' guibg=NONE ctermbg=NONE')
        end

        -- Filetype icons can retain background via DevIcon highlight groups.
        local devicon_hls = vim.fn.getcompletion('DevIcon', 'highlight')
        for _, hl in ipairs(devicon_hls) do
          vim.cmd('highlight ' .. hl .. ' guibg=NONE ctermbg=NONE')
        end
      end

      local path_depth_limit = 2

      local function limited_filename()
        local filename = vim.fn.expand('%:t')
        if filename == '' then
          return ''
        end

        local rel = vim.fn.fnamemodify('%', ':~:.')
        if rel == '' then
          return filename
        end

        local segments = vim.split(rel, '[\\\\/]', { trimempty = true })
        if #segments == 0 then
          return filename
        end

        local file = segments[#segments]
        table.remove(segments, #segments)

        if #segments == 0 then
          return file
        end

        local start_idx = math.max(1, #segments - path_depth_limit + 1)
        local kept = {}
        for i = start_idx, #segments do
          kept[#kept + 1] = segments[i]
        end

        if #kept == 0 then
          return file
        end

        return table.concat(kept, '/') .. '/' .. file
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

      local function navic_component()
        if not has_navic then
          return ''
        end

        if not navic.is_available() then
          return ''
        end

        return navic.get_location()
      end

      require('lualine').setup {
        options = {
          theme = transparent_theme,
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
            { limited_filename },
            { navic_component },
          },
          lualine_x = {
            { 'filetype', color = { bg = 'NONE' } },
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
