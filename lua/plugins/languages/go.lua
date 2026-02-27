vim.lsp.enable "gopls"
return {
  { import = "astrocommunity.pack.go" },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
}
