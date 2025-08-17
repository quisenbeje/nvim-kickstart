-- conform
-- https://github.com/stevearc/conform.nvim
return { -- Autoformat
   'stevearc/conform.nvim',
   event = { 'BufWritePre' },
   cmd = { 'ConformInfo' },
   keys = {
      {
         '<leader>lf',
         function()
            require('conform').format { async = true, lsp_format = 'fallback' }
         end,
         mode = '',
         desc = '[F]ormat buffer',
      },
   },
   -- This will provide type hinting with LuaLS
   ---@module "conform"
   ---@type conform.setupOpts
   opts = {
      -- Define your formatters
      formatters_by_ft = {
         lua = { 'stylua' },
         -- python = { 'isort', 'black' },
         python = { 'ruff_fix', 'ruff_format' },
         -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
         javascript = { 'prettierd', 'prettier' },
         -- typescript = { 'prettierd', 'prettier', stop_after_first = true },
         typescript = { 'prettierd', 'prettier' },
         markdown = { 'prettierd', 'prettier' },
      },
      -- Set default options
      default_format_opts = {
         lsp_format = 'fallback',
      },
      -- Set up format-on-save
      format_on_save = {
         lsp_fallback = true,
         async = false,
         timeout_ms = 500,
      },
      -- Customize formatters
      formatters = {
         shfmt = {
            prepend_args = { '-i', '2' },
         },
      },
   },
   init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
   end,
   -- notify_on_error = false,
   -- format_on_save = function(bufnr)
   --    -- Disable "format_on_save lsp_fallback" for languages that don't
   --    -- have a well standardized coding style. You can add additional
   --    -- languages here or re-enable it for the disabled ones.
   --    local disable_filetypes = { c = true, cpp = true }
   --    if disable_filetypes[vim.bo[bufnr].filetype] then
   --       return nil
   --    else
   --       return {
   --          timeout_ms = 500,
   --          lsp_format = 'fallback',
   --       }
   --    end
   -- end,
   -- formatters_by_ft = {
   --    lua = { 'stylua' },
   --    -- Conform can also run multiple formatters sequentially
   --    -- python = { "isort", "black" },
   --    --
   --    -- You can use 'stop_after_first' to run the first available formatter from the list
   --    javascript = { 'prettierd', 'prettier', stop_after_first = true },
   -- },
   -- },
}
