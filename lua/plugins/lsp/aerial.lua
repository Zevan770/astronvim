---@type LazySpec
return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    opts = require("astrocore").extend_tbl(opts, {
      manage_folds = true,
      link_folds_to_tree = true,
    })
    return opts
  end,
}
