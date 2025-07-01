-- if vim.fn.has "android" then return {} end
---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
  },
  {
    "folke/lazydev.nvim",
    dependencies = {
      "https://github.com/nekowinston/wezterm-types",
    },
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
      library = {
        -- It can also be a table with trigger words / mods
        -- Only load luvit types when the `vim.uv` word is found
        -- { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "neotest", mods = { "neotest" } },
        -- "lazy.nvim",
      },
    },
  },
}
