return {
   'folke/snacks.nvim',
   priority = 1000,
   lazy = false,
   ---@type snacks.Config
   keys = {
      {
         '<leader>e',
         function()
            Snacks.explorer()
         end,
         desc = '[e]xplorer',
      },
      {
         '<leader>fe',
         function()
            Snacks.explorer()
         end,
         desc = 'explorer',
      },
      {
         '<leader>/',
         function()
            Snacks.picker.git_grep()
         end,
         desc = 'Grep',
      },
      {
         '<leader>sg',
         function()
            Snacks.picker.grep {
               -- Exclude results from grep picker
               -- I think these have to be specified in gitignore syntax
               exclude = { 'dictionaries/words.txt' },
            }
         end,
         desc = 'Grep',
      },
      {
         '<leader>sw',
         function()
            Snacks.picker.grep_word()
         end,
         desc = 'Visual selection or word',
         mode = { 'n', 'x' },
      },
      {
         '<leader>si',
         function()
            Snacks.picker.icons()
         end,
         desc = 'Icons',
      },
      -- Open git log in vertical view
      {
         '<leader>gl',
         function()
            Snacks.picker.git_log {
               finder = 'git_log',
               format = 'git_log',
               preview = 'git_show',
               confirm = 'git_checkout',
               layout = 'vertical',
            }
         end,
         desc = 'Git Log',
      },
      -- -- Iterate through incomplete tasks in Snacks_picker
      {
         -- -- You can confirm in your teminal lamw26wmal with:
         -- -- rg "^\s*-\s\[ \]" test-markdown.md
         '<leader>tt',
         function()
            Snacks.picker.grep {
               prompt = ' ',
               -- pass your desired search as a static pattern
               search = '^\\s*- \\[ \\]',
               -- we enable regex so the pattern is interpreted as a regex
               regex = true,
               -- no “live grep” needed here since we have a fixed pattern
               live = false,
               -- restrict search to the current working directory
               dirs = { vim.fn.getcwd() },
               -- include files ignored by .gitignore
               args = { '--no-ignore' },
               -- Start in normal mode
               on_show = function()
                  vim.cmd.stopinsert()
               end,
               finder = 'grep',
               format = 'file',
               show_empty = true,
               supports_live = false,
               layout = 'ivy',
            }
         end,
         desc = '[P]Search for incomplete tasks',
      },
      -- -- Iterate throuth completed tasks in Snacks_picker lamw26wmal
      {
         '<leader>tc',
         function()
            Snacks.picker.grep {
               prompt = ' ',
               -- pass your desired search as a static pattern
               search = '^\\s*- \\[x\\] `done:',
               -- we enable regex so the pattern is interpreted as a regex
               regex = true,
               -- no “live grep” needed here since we have a fixed pattern
               live = false,
               -- restrict search to the current working directory
               dirs = { vim.fn.getcwd() },
               -- include files ignored by .gitignore
               args = { '--no-ignore' },
               -- Start in normal mode
               on_show = function()
                  vim.cmd.stopinsert()
               end,
               finder = 'grep',
               format = 'file',
               show_empty = true,
               supports_live = false,
               layout = 'ivy',
            }
         end,
         desc = '[P]Search for complete tasks',
      },
      -- -- List git branches with Snacks_picker to quickly switch to a new branch
      {
         '<leader>sb',
         function()
            Snacks.picker.git_branches {
               layout = 'select',
            }
         end,
         desc = 'Branches',
      },
      -- Used in LazyVim to view the different keymaps, this by default is
      -- configured as <leader>sk but I run it too often
      -- Sometimes I need to see if a keymap is already taken or not
      {
         '<leader>sk',
         function()
            Snacks.picker.keymaps {
               layout = 'vertical',
            }
         end,
         desc = 'keymaps picker (snacks)',
      },
      -- File picker
      {
         '<leader><space>',
         function()
            Snacks.picker.files {
               finder = 'files',
               format = 'file',
               show_empty = true,
               supports_live = true,
               -- In case you want to override the layout for this keymap
               -- layout = "vscode",
            }
         end,
         desc = 'Find Files',
      },
      -- Navigate my buffers
      {
         '<leader>bb',
         function()
            Snacks.picker.buffers {
               -- I always want my buffers picker to start in normal mode
               on_show = function()
                  vim.cmd.stopinsert()
               end,
               finder = 'buffers',
               format = 'buffer',
               hidden = false,
               unloaded = true,
               current = true,
               sort_lastused = true,
               win = {
                  input = {
                     keys = {
                        ['d'] = 'bufdelete',
                     },
                  },
                  list = { keys = { ['d'] = 'bufdelete' } },
               },
               -- In case you want to override the layout for this keymap
               -- layout = "ivy",
            }
         end,
         desc = 'buffers picker (snacks)',
      },
   },
   opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- bigfile = { enabled = true },
      bigfile = {
         notify = true, -- show notification when big file detected
         size = 5 * 1024 * 1024,
         line_length = 1000, -- average line length (useful for minified files)
         -- Enable or disable features when big file detected
         ---@param ctx {buf: number, ft:string}
         setup = function(ctx)
            if vim.fn.exists ':NoMatchParen' ~= 0 then
               vim.cmd [[NoMatchParen]]
            end
            Snacks.util.wo(0, { foldmethod = 'indent', statuscolumn = '', conceallevel = 0 })
            vim.b.minianimate_disable = true
            vim.schedule(function()
               if vim.api.nvim_buf_is_valid(ctx.buf) then
                  vim.bo[ctx.buf].syntax = ctx.ft
                  Snacks.indent.disable()
               end
            end)
         end,
      },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = {
         enabled = true,
         debug = {
            scores = false, -- show scores in the list
         },
         -- I like the "ivy" layout, so I set it as the default globaly, you can
         -- still override it in different keymaps
         layout = {
            preset = 'ivy',
            -- When reaching the bottom of the results in the picker, I don't want
            -- it to cycle and go back to the top
            cycle = false,
         },
         layouts = {
            -- I wanted to modify the ivy layout height and preview pane width,
            -- this is the only way I was able to do it
            -- NOTE: I don't think this is the right way as I'm declaring all the
            -- other values below, if you know a better way, let me know
            --
            -- Then call this layout in the keymaps above
            -- got example from here
            -- https://github.com/folke/snacks.nvim/discussions/468
            ivy = {
               layout = {
                  box = 'vertical',
                  backdrop = false,
                  row = -1,
                  width = 0,
                  height = 0.5,
                  border = 'top',
                  title = ' {title} {live} {flags}',
                  title_pos = 'left',
                  { win = 'input', height = 1, border = 'bottom' },
                  {
                     box = 'horizontal',
                     { win = 'list', border = 'none' },
                     { win = 'preview', title = '{preview}', width = 0.5, border = 'left' },
                  },
               },
            },
            -- I wanted to modify the layout width
            --
            vertical = {
               layout = {
                  backdrop = false,
                  width = 0.8,
                  min_width = 80,
                  height = 0.8,
                  min_height = 30,
                  box = 'vertical',
                  border = 'rounded',
                  title = '{title} {live} {flags}',
                  title_pos = 'center',
                  { win = 'input', height = 1, border = 'bottom' },
                  { win = 'list', border = 'none' },
                  { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
               },
            },
         },
         matcher = {
            frecency = true,
         },
         win = {
            input = {
               keys = {
                  -- to close the picker on ESC instead of going to normal mode,
                  -- add the following keymap to your config
                  ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
                  -- I'm used to scrolling like this in LazyGit
                  ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                  ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                  ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
                  ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
               },
            },
         },
         formatters = {
            file = {
               filename_first = true, -- display filename before the file path
               truncate = 80,
            },
         },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
   },
}
