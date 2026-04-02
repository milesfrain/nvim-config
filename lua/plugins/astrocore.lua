-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        wildmode = "longest:list,full",
        wildoptions = "tagfile",
      },
    },
    mappings = {
      n = {
        ["gh"] = {
          function()
            local bufnr = vim.api.nvim_get_current_buf()
            local client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
            if not client then return vim.notify("clangd not attached to current buffer", vim.log.levels.WARN) end
            local params = vim.lsp.util.make_text_document_params(bufnr)
            -- clangd exposes `textDocument/switchSourceHeader` as a custom extension method,
            -- so Neovim's generated LSP method types reject it even though the request is valid.
            ---@diagnostic disable-next-line:param-type-mismatch
            client:request("textDocument/switchSourceHeader", params, function(err, result)
              if err then return vim.notify(tostring(err), vim.log.levels.ERROR) end
              if not result then return vim.notify("corresponding file cannot be determined", vim.log.levels.WARN) end
              vim.cmd.edit(vim.uri_to_fname(result))
            end, bufnr)
          end,
          desc = "Switch source/header (clangd)",
        },
        ["<C-n>"] = {
          function()
            local filepath = vim.fn.expand "%:."
            local line = vim.fn.line "."
            local reference = filepath .. ":" .. line
            vim.fn.setreg("+", reference)
            vim.notify("Copied: " .. reference, vim.log.levels.INFO)
          end,
          desc = "Copy file reference to clipboard",
        },
      },
      v = {
        ["<C-n>"] = {
          function()
            local filepath = vim.fn.expand "%:."
            local start_line = vim.fn.line "v"
            local end_line = vim.fn.line "."

            if start_line > end_line then
              start_line, end_line = end_line, start_line
            end

            local reference = filepath .. ":" .. start_line
            if start_line ~= end_line then reference = reference .. "-" .. end_line end

            vim.fn.setreg("+", reference)
            vim.notify("Copied: " .. reference, vim.log.levels.INFO)
            vim.cmd "normal! \27"
          end,
          desc = "Copy file reference with line range to clipboard",
        },
      },
    },
  },
}
