return {
  'echasnovski/mini.cursorword',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('mini.cursorword').setup()

    local function set_hl()
      local cbg = vim.o.background == 'dark' and '#3a3a3a' or '#EEEEEE'
      vim.api.nvim_set_hl(0, 'MiniCursorword', { bg = cbg, underline = false })
      vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', { bg = cbg, underline = false })
    end

    set_hl()
    vim.g.minicursorword_disable = true

    vim.api.nvim_create_autocmd('ModeChanged', {
      callback = function()
        local visual = vim.fn.mode():match '^[vV\22]'
        vim.g.minicursorword_disable = not visual
        if visual then
          set_hl()
        end
      end,
    })

    vim.api.nvim_create_autocmd('ColorScheme', { callback = set_hl })
  end,
}
