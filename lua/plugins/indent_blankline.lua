return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    enabled = false,
    main = 'ibl',
    opts = {},
    config = function()
      require('ibl').setup {
        scope = {
          enabled = false,
          show_start = false,
          show_end = false,
        },
        indent = {
          char = '▏',
          highlight = { 'CursorLineNr' },
          smart_indent_cap = true,
        },
      }
    end,
  },
}
