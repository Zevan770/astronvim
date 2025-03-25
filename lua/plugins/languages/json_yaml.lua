return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.yaml" },
    { import = "astrocommunity.programming-language-support.nvim-jqx" },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        my_ft_json = {
          {
            event = "Filetype",
            pattern = "json",
            callback = function() vim.o.shiftwidth = 4 end,
          },
        },
      },
    },
  },
}
