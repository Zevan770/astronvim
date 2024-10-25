---@type LazySpec
return {
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
  {
    "willothy/flatten.nvim",
    opts = {
      one_per = { wezterm = true },
    },
  },
}
