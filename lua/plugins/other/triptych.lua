-- file manager
return {
  {
    "simonmclean/triptych.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      -- "nvim-tree/nvim-web-devicons", -- optional for icons
      -- "antosha417/nvim-lsp-file-operations", -- optional LSP integration
    },
    opts = {}, -- config options here
    keys = {
      { "<leader>-", "<Cmd>Triptych<CR>", silent = true },
    },
  },
}
