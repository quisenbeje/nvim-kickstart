--  See `:help lua-guide-autocommands`
print 'autocmd: sourced'

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    if require('nvim-treesitter.parsers').has_parser() then
      print 'parser found'
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      -- vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.o.foldtext = 'v:lua.vim.treesitter.foldtext()'
    else
      vim.opt.foldmethod = 'syntax'
    end
  end,
})
