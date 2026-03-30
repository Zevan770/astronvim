if true then return {} end
-- customize mason plugins
local disable_auto_install = function(_, opts) opts.ensure_installed = {} end

return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    -- enabled = false,
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = disable_auto_install,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    -- enabled = false,
    -- overrides `require("mason-null-ls").setup(...)`
    opts = disable_auto_install,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    -- enabled = false,
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = disable_auto_install,
  },
}
