return { -- Collection of various small independent plugins/modules
  'sindrets/diffview.nvim',
  config = function()
    -- keybindings
    local wk = require 'which-key'
    wk.add {
      -- diff group
      { '<leader>d', group = 'diff' }, -- group
      { '<leader>dW', '<Cmd>windo diffoff<Cr>', desc = 'Diff windows off' },
      { '<leader>dw', '<Cmd>windo diffthis<Cr>', desc = 'Diff windows' },
      { '<leader>dB', '<Cmd>bufdo diffoff<Cr>', desc = 'Diff buffers off' },
      { '<leader>db', '<Cmd>bufdo diffthis<Cr>', desc = 'Diff buffers' },
      { '<leader>dc', '<Cmd>DiffviewClose<Cr>', desc = 'Diffview close' },
      { '<leader>do', '<Cmd>DiffviewOpen<Cr>', desc = 'Diffview open' },
      { '<leader>df', '<Cmd>DiffviewFileHistory<Cr>', desc = 'Diffview file history' },
      { '<leader>de', '<Cmd>DiffviewToggleFiles<Cr>', desc = 'Diffview file explorer' },
    }
  end,
}
