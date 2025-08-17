return {
   'kevinhwang91/nvim-ufo',
   dependencies = { 'kevinhwang91/promise-async' },
   enabled = true,
   event = 'BufReadPost',
   -- event = 'VeryLazy',
   keys = {
      { 'zc', mode = 'n', desc = 'Fold current line' },
      { 'zo', mode = 'n', desc = 'Unfold current line' },
      { 'za', mode = 'n', desc = 'Toggle fold current line' },
      { 'zA', mode = 'n', desc = 'Toggle fold all lines' },
      { 'zr', mode = 'n', desc = 'Unfold all lines' },
      { 'zR', mode = 'n', desc = 'Fold all lines' },
   },
   opts = {
      provider_selector = function()
         return { 'lsp', 'indent' }
      end,
      open_fold_hl_timeout = 100,
      close_fold_kinds = { 'imports', 'comment' },
      preview = {
         win_config = {
            border = 'single',
            winhighlight = 'Normal:Folded',
            winblend = 0,
         },
         mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']',
         },
      },
   },
   config = function()
      vim.o.foldenable = true
      -- vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldcolumn = 'auto:9' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep:│,foldclose:'

      require('ufo').setup {
         provider_selector = function(bufnr, filetype, buftype)
            return { 'treesitter', 'indent' }
         end,
      }

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', '<leader>v', require('ufo').peekFoldedLinesUnderCursor)
      -- require('nvim-ufo').setup()
   end,
}
