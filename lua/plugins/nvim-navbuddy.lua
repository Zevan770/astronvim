---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    -- your lsp config or other stuff
  },
  {
    "astronvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>jn"] = { desc = "navbuddy", function() vim.cmd "Navbuddy" end },
        },
      },
    },
  },
}
