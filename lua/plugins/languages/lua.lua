-- if vim.fn.has "android" then return {} end
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      hint = {
        -- semicolon = "All",
      },
    },
  },
  single_file_support = true,
})
---@type LazySpec
return {
  { import = "astrocommunity.pack.lua" },
  {
    "folke/lazydev.nvim",
    dependencies = {
      { "gonstoll/wezterm-types", lazy = true },
    },
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
      library = {
        -- It can also be a table with trigger words / mods
        -- Only load luvit types when the `vim.uv` word is found
        -- { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "nvim-lspconfig" },
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "neotest", mods = { "neotest" } },
        -- "lazy.nvim",
      },
    },
  },
}
