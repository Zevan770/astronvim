---@type LazySpec
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(opts, {
        library = {
          {
            path = "C:/Users/86135/.vscode/extensions/asvetliakov.vscode-neovim-1.8.1/runtime/lua/vscode-neovim/",
            words = { "vscode" },
          },
        },
      })
    end,
  },
}
