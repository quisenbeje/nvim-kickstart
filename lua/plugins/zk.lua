return {
   'zk-org/zk-nvim',
   config = function()
      require('zk').setup {
         -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
         -- or select" (`vim.ui.select`).
         -- picker = 'select',
         picker = 'snacks_picker',

         lsp = {
            -- `config` is passed to `vim.lsp.start(config)`
            config = {
               name = 'zk',
               cmd = { 'zk', 'lsp' },
               filetypes = { 'markdown' },
               -- on_attach = ...
               -- etc, see `:h vim.lsp.start()`
            },

            -- automatically attach buffers in a zk notebook that match the given filetypes
            auto_attach = {
               enabled = true,
            },
         },
      }
   end,
   keys = {
      { '<leader>zg', '<cmd>ZkCd<cr>', mode = 'n', desc = 'goto notebook' },
      { '<leader>zn', '<cmd>ZkNew {title = vim.fn.input("Title: ")}<cr>', mode = 'n', desc = 'new note' },
      { '<leader>zn', "<cmd>'<,'>ZkNewFromTitleSelection<cr>", mode = 'v', desc = 'new note [selected title]' },
      { '<leader>zb', '<cmd>ZkBacklinks<cr>', mode = 'n', desc = 'backlinks [buffer]' },
      { '<leader>zB', '<cmd>ZkBuffers<cr>', mode = 'n', desc = 'buffer picker' },
      { '<leader>zc', '<cmd>ZkNewFromContentSelection<cr>', mode = 'v', desc = 'new note [selected content]' },
      { '<leader>zf', '<cmd>ZkNotes<cr>', mode = 'n', desc = 'find notes' },
      { '<leader>zt', '<cmd>ZkTags<cr>', mode = 'n', desc = 'tags' },
      {
         '<leader>zD',
         '<cmd>ZkNew {group = "daily"}<cr>',
         mode = 'n',
         desc = 'todo',
      },
      {
         '<leader>zT',
         '<cmd>ZkNew {group = "todo", title = vim.fn.input("Title: ")}<cr>',
         mode = 'n',
         desc = 'todo',
      },
      { '<leader>zL', '<cmd>ZkLinks<cr>', mode = 'n', desc = 'links [buffer]' },
      { '<leader>zl', '<cmd>ZkInsertLink<cr>', mode = 'n', desc = 'new link' },
      { '<leader>zl', '<cmd>ZkInsertLinkAtSelection<cr>', mode = 'v', desc = 'new link [selection]' },
      { '<leader>zi', '<cmd>ZkIndex<cr>', mode = 'n', desc = 'index' },
   },
}
