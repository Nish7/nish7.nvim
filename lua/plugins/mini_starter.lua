return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local starter = require 'mini.starter'

      starter.setup {
        content_hooks = {
          starter.gen_hook.adding_bullet ' ',
          starter.gen_hook.aligning('center', 'center'),
        },
        footer = '',
      }
    end,
  },
}
