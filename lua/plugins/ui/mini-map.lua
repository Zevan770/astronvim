return {
  -- { import = "astrocommunity.split-and-window.minimap-vim" },
  { import = "astrocommunity.split-and-window.mini-map" },
  {
    "echasnovski/mini.map",
    opts = {
      window = {
        winblend = 99,
      },
    },
    specs = {
      {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = { integrations = { mini = true } },
      },
    },
  },
}
