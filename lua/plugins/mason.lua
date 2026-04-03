-- Customize Mason

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "pyright",
        -- "svlangserver", -- verilog, rarely used

        -- Installed by default or by other packs
        -- "codelldb",
        -- "lua-language-server",
        -- "selene",
        -- "stylua",
        -- "taplo",
      },
    },
  },
}
