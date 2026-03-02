vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.pl',
  desc = 'Detect and set the proper file type for Prolog files',
  callback = function()
    vim.cmd 'set filetype=prolog'
  end,
})
