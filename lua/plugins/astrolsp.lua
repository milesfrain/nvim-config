-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    formatting = {
      format_on_save = {
        ignore_filetypes = { "markdown" },
      },
    },
    config = {
      clangd = {
        cmd = {
          "clangd",
          "--log=verbose",
          "--query-driver="
            .. vim.fn.expand "~"
            .. "/.platformio/packages/*/bin/arm-*-eabi-g*,"
            .. vim.fn.getcwd()
            .. "/toolchain/*/bin/arm-*-eabi-g*",
        },
      },
    },
  },
}
