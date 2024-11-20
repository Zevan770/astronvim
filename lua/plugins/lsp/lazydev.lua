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
          -- It can also be a table with trigger words / mods
          -- Only load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv" } },
          { path = "astrocore" },
          -- Load the wezterm types when the `wezterm` module is required
          -- Needs `justinsgithub/wezterm-types` to be installed
          { path = "wezterm-types", mods = { "wezterm" } },
          "lazy.nvim",
        },
      })
    end,
  },
  {
    "https://github.com/nekowinston/wezterm-types",
    dev = true,
  },
}
