return {
   'renerocksai/telekasten.nvim',
   dependencies = {
      'nvim-telescope/telescope.nvim',
   },
   config = function()
      require('telekasten').setup {
         home = vim.fn.expand '~/Dropbox/telekasten',
         auto_set_filetype = false,
      }
   end,
   keys = {
      { '<leader>fn', '<cmd>Telekasten find_notes<cr>', mode = 'n', desc = 'notes' },
   },
}
