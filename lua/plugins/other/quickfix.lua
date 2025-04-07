---@type LazySpec
return {
  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.quickfix.quicker-nvim" },
  {
    "romainl/vim-qf",
    dependencies = {

      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          g = {},
        },
      },
    },
  },
}
