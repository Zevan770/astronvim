-- if vim.fn.has "android" then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.pack.lua" },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(v) return v ~= "lua-language-server" end, opts.ensure_installed)
    end,
  },
  {
    "astronvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      config = {
        lua_ls = {
          reuse_client = function(client, config) return true end,
        },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    dependencies = {
      { "DrKJeff16/wezterm-types", lazy = true },
    },
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
      library = {
        -- It can also be a table with trigger words / mods
        -- Only load luvit types when the `vim.uv` word is found
        -- { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "snacks.nvim",   words = { "Snacks" } },
        { path = "nvim-lspconfig" },
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "neotest",       mods = { "neotest" } },
        -- "lazy.nvim",
      },
    },
  },
}
