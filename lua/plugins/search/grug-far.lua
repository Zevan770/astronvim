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
      {
        "folke/which-key.nvim",
        optional = true,
        opts = function(_, opts)
          if not not opts.disable then
            for i, x in pairs(opts.disable.ft) do
              if x == "grug-far" then
                table.remove(opts.disable.ft, i)
                break
              end
            end
          end
        end,
      },
    },
    ---@param opts GrugFarOptions
    opts = function(self, opts) opts.debounceMs = 1000 end,
  },
}
