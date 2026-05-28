-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "max397574/better-escape.nvim",
    enabled = false,
  },
  {
    "kevinhwang91/nvim-bqf",
    opts = {
      preview = {
        winblend = 0,
      },
    },
    config = function(_, opts)
      require("bqf").setup(opts)
      local PreviewSession = require "bqf.preview.session"
      local old_new = PreviewSession.new
      PreviewSession.new = function(self, winid, focusable)
        local session = old_new(self, winid, focusable)
        session.full = true
        return session
      end
    end,
  },
}
