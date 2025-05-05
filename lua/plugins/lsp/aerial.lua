---@type LazySpec
return {
  "stevearc/aerial.nvim",
  version = false,
  opts = function(_, opts)
    opts = require("astrocore").extend_tbl(opts, {
      manage_folds = false,
      link_folds_to_tree = false,
      link_tree_to_folds = false,
    })
    return opts
  end,
}
