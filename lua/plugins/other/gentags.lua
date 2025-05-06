---@type LazySpec
return {
  {
    "linrongbin16/gentags.nvim",
    config = true,
    enabled = false,
  },
  {
    "JMarkin/gentags.lua",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = {},
  },
}
