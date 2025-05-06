---@type LazySpec
return {
  { import = "astrocommunity.search.grug-far-nvim" },
  {
    "MagicDuck/grug-far.nvim",
    specs = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts) local maps = assert(opts.mappings) end,
      },
    },
    ---@module "grug-far"
    ---@param opts GrugFarOptions
    opts = function(_, opts) opts.debounceMs = 1000 end,
  },
}
