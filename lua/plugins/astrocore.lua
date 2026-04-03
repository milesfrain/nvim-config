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

            if start_line > end_line then start_line, end_line = end_line, start_line end

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
