---@type LazySpec
return {
  { import = "astrocommunity.search.grug-far-nvim" },
  {
    "MagicDuck/grug-far.nvim",
    ---@module "grug-far"
    ---@param opts GrugFarOptions
    opts = function(_, opts) opts.debounceMs = 1000 end,
  },
}
