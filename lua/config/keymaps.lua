--  See `:help vim.keymap.set()`
print 'keymaps: sourced'
local map = vim.keymap.set
local keymap = vim.api.nvim_set_keymap

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds for windows
map('n', '<leader>wh', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<leader>wl', '<C-w>l', { desc = 'Move focus to the right window' })
map('n', '<leader>wj', '<C-w>j', { desc = 'Move focus to the lower window' })
map('n', '<leader>wk', '<C-w>k', { desc = 'Move focus to the upper window' })
map('n', '<leader>wH', '<C-w>H', { desc = 'Move window to the far left' })
map('n', '<leader>wL', '<C-w>L', { desc = 'Move window to the far right' })
map('n', '<leader>wJ', '<C-w>J', { desc = 'Move window to the far bottom' })
map('n', '<leader>wK', '<C-w>K', { desc = 'Move window to the far top' })
map('n', '<leader>wo', '<C-w>o', { desc = 'Only: close all other windows' })
map('n', '<leader>wc', '<C-w>c', { desc = 'Close window' })
map('n', '<leader>wf', '<C-w>f', { desc = 'File under cursor' })
map('n', '<leader>wF', '<C-w>f<C-w>c', { desc = 'File under cursor (bkgd)' })
map('n', '<leader>wd', '<Cmd>windo diffthis<Cr>', { desc = 'Diff windows' })
map('n', '<leader>wD', '<Cmd>windo diffoff<Cr>', { desc = 'Diff off' })

local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Paste over currently selected text without yanking it
keymap('x', 'p', '"_dP', default_opts)
-- keymap('x', 'p', 'P', default_opts)

-- Folds
keymap('n', '<Tab>', 'za', default_opts)

-- Visual line wraps
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- When you do joins with J it will keep your cursor at the beginning instead of at the end
map('n', 'J', 'mzJ`z')

-- When searching for stuff, search results show in the middle
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

local whichkey = require 'which-key'
local maps = {

  -- find/file additions
  -- { "<leader>fa", "<Cmd>GpChatFinder<Cr>", desc = "Ai Chats" },

  -- buffer additions
  -- {
  --   '<leader>bb',
  --   function()
  --     require('fzf-lua').buffers()
  --   end,
  --   desc = 'Find',
  -- },
  { '<leader>bn', '<Cmd>bn<Cr>', desc = 'Next' },
  { '<leader>bN', '<Cmd>bp<Cr>', desc = 'Previous' },
  { '<leader>b;', '<Cmd>e#<Cr>', desc = 'Last' },

  -- diff group
  { '<leader>d', group = 'diff' }, -- group
  { '<leader>dW', '<Cmd>windo diffoff<Cr>', desc = 'Diff windows off' },
  { '<leader>dw', '<Cmd>windo diffthis<Cr>', desc = 'Diff windows' },
  { '<leader>wd', '<Cmd>windo diffthis<Cr>', desc = 'Diff windows' },
  { '<leader>dB', '<Cmd>bufdo diffoff<Cr>', desc = 'Diff buffers off' },
  { '<leader>db', '<Cmd>bufdo diffthis<Cr>', desc = 'Diff buffers' },
  { '<leader>dc', '<Cmd>DiffviewClose<Cr>', desc = 'Diffview close' },
  { '<leader>do', '<Cmd>DiffviewOpen<Cr>', desc = 'Diffview open' },
  { '<leader>df', '<Cmd>DiffviewFileHistory<Cr>', desc = 'Diffview file history' },
  { '<leader>de', '<Cmd>DiffviewToggleFiles<Cr>', desc = 'Diffview file explorer' },

  -- git additions
  { '<leader>go', '<cmd>Neogit<CR>', desc = 'Open status' },

  -- notes group
  { '<leader>n', group = 'notes' }, -- group

  -- ai additions
  { '<leader>a', group = 'ai' }, -- group
  { '<leader>an', '<Cmd>GpChatNew<Cr>', desc = 'New Chats' },
  { '<leader>af', '<Cmd>GpChatFinder<Cr>', desc = 'Find Chats' },
  { '<leader>aa', '<Cmd>GpChatToggle popup<Cr>', desc = 'Toggle Last Chat (popup)' },
  { '<leader>av', '<Cmd>GpChatToggle vsplit<Cr>', desc = 'Toggle Last Chat (vsplit)' },
  { '<leader>ad', '<Cmd>GpChatDelete<Cr>', desc = 'Delete Chat' },
}

whichkey.add(maps)
