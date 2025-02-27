return {
  'lervag/vimtex',
  ft = 'tex', -- Load only for .tex files
  config = function()
    vim.g.vimtex_view_method = 'general' -- Use a custom viewer
    vim.g.vimtex_view_general_viewer = 'chrome' -- Replace with your browser (e.g., chrome, safari)
    vim.g.vimtex_view_general_options = '@pdf' -- Pass the PDF file to the browser
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      continuous = 1, -- Enable continuous compilation
    }
  end,
}
