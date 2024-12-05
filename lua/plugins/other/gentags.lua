---@type LazySpec
return {
  {
    "linrongbin16/gentags.nvim",
    config = true,
    enabled = false,
  },
  {
    "JMarkin/gentags.lua",
    cond = vim.fn.executable "ctags" == 1,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    enabled = not vim.fn.has "win32",
    event = "VeryLazy",
    opts = {},
  },
}
