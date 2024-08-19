-- if true then return {} end
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

  -- navic
  {
    "SmiteshP/nvim-navic",
    opts = {
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = false,
      click = true,
      format_text = function(text) return text end,
    },
  },
  {
    "catppuccin",
    opts = {
      integretions = {
        navic = {
          enabled = true,
        },
      },
    },
  },
  -- {
  --   ""
  -- }
}
