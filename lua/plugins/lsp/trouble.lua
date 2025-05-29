---@type LazySpec
return {
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  {
    "artemave/workspace-diagnostics.nvim",
    opts = {},
    keys = {
      {
        "<leader>xd",
        function()
          for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
            require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
          end
        end,
        desc = "Populate workspace diagnostics",
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {
      auto_open = false, -- auto open when there are items
    },
    keys = { { "<leader>lx", "<cmd>Trouble lsp toggle<CR>", mode = { "n", "v" }, desc = "Trouble lsp" } },
  },
}
