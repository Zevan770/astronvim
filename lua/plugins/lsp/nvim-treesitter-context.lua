-- if true then return {} end
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User AstroFile",
    cmd = { "TSContextToggle" },
    opts = function(_, opts)
      opts.max_lines = 5
      opts.min_window_height = 0
      vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })
      -- vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
      -- vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "CursorLineNr" })
    end,
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
  },
}
