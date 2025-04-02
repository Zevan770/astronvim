-- if vim.fn.has "android" then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
  },
  {
    "folke/lazydev.nvim",
    dependences = {
      "https://github.com/nekowinston/wezterm-types",
      dev = true,
    },
    opts = {
      library = {
        -- It can also be a table with trigger words / mods
        -- Only load luvit types when the `vim.uv` word is found
        -- { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- Load the wezterm types when the `wezterm` module is required
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        -- "lazy.nvim",
      },
    },
  },
}
