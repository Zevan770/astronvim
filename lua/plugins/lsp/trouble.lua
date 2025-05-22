---@type LazySpec
return {
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  {
    "folke/trouble.nvim",
    opts = {
      auto_open = false, -- auto open when there are items
    },
    keys = { { "<leader>lx", "<cmd>Trouble lsp toggle<CR>", mode = { "n", "v" }, desc = "Trouble lsp" } },
  },
}
