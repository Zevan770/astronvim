---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) opts.ensure_installed = {} end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = function(_, opts) opts.ensure_installed = {} end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    enabled = false,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    enabled = false,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    enabled = false,
  },
}
