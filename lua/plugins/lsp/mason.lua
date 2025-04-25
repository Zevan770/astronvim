if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- install formatters
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    enabled = false,
    -- overrides `require("mason-lspconfig").setup(...)`
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    -- overrides `require("mason-null-ls").setup(...)`
    enabled = false,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    -- overrides `require("mason-nvim-dap").setup(...)`
    enabled = false,
  },
}
