-- Customize None-ls sources

---@type LazySpec
return {
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      handlers = {
        prettier = function()
          local null_ls = require "null-ls"
          null_ls.register(null_ls.builtins.formatting.prettier.with {
            filetypes = { "markdown" },
          })
        end,
      },
    },
  },
}
