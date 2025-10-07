return {
  { import = "astrocommunity.editing-support.neogen" },
  {
    "danymat/neogen",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          my_utils.key.replace_group("n", maps, "<Leader>a", "<Leader>ia")
        end,
      },
    },
  },
}
