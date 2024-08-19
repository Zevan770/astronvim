-- if true then return {} end
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  -- opts = function(_, opts)
  --   vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CurSorLine" })
  --   -- vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
  --   vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "CurSorLineNr" })
  -- end,
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>ux"] = {
            "<cmd>TSContextToggle<CR>",
            desc = "Toggle treesitter context",
          },
        },
      },
    },
  },
}
