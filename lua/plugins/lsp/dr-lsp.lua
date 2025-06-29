---@type LazySpec
return {
  {
    "chrisgrieser/nvim-dr-lsp",
    event = "LspAttach",
    enabled = false,
    opts = {
      highlightCursorWordReferences = {
        enable = false,
      },
    },
    specs = {
      {
        "rebelot/heirline.nvim",
        dependencies = {
          "Zeioth/heirline-components.nvim",
        },
        opts = function(_, opts)
          local bar = require "utils.bar"
          table.insert(opts.statusline, 6, bar.lsp_def_ref())
        end,
      },
    },
  },
}
