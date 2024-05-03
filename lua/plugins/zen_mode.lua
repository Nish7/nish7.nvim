return {
  'folke/zen-mode.nvim',
  config = function()
    require('zen-mode').setup {
      window = {
        backdrop = 0,
        width = 0.69,
      },
    }
  end,
}
