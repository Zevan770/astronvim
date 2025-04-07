return {
  { import = "astrocommunity.code-runner.overseer-nvim" },
  {
    "stevearc/overseer.nvim",
    specs = {
      { "AstroNvim/astroui", opts = { icons = { Overseer = "" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          utils.replace_group("n", maps, "<leader>M", "<Leader>:")
        end,
      },
    },
  },
}
