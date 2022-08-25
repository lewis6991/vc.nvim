vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.vc',
  callback = function()
    vim.bo.filetype = 'vc'
  end
})
