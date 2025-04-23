---@type LazySpec
return {
  {
    "linrongbin16/gentags.nvim",
    config = true,
    enabled = false,
  },
  {
    "JMarkin/gentags.lua",
    enabled = not my_utils.is_windows and vim.fn.executable "ctags" == 1,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = {},
  },
}
