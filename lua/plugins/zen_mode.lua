return {
  'folke/zen-mode.nvim',
  config = function()
    require('zen-mode').setup {
      window = {
        backdrop = 1,
        width = 0.69,
      },
    }
  end,
}
