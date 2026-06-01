---@type LazySpec
return {
  "folke/which-key.nvim",
  ---@class wk.Opts
  opts = {
    preset = "modern",
    delay = 100,
    keys = {
      scroll_down = "<tab>", -- binding to scroll down inside the popup
      scroll_up = "<S-tab>", -- binding to scroll up inside the popup
    },
    icons = {
      rules = {},
    },
  },
  config = function(self, opts)
    require("which-key").setup(opts)
    local wk = require "which-key"
    wk.add {
      { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
      {
        "<Leader>b",
        group = "buffers",
        expand = function() return require("which-key.extras").expand.buf() end,
      },
    }
  end,
}
