return {
  {
    "atiladefreitas/dooing",
    config = function() require("dooing").setup {} end,
  },

  {
    "Dan7h3x/LazyDo",
    branch = "main",
    cmd = { "LazyDoToggle", "LazyDoPin", "LazyDoToggleStorage" },
    keys = { -- recommended keymap for easy toggle LazyDo in normal and insert modes (arbitrary)
      { "<leader>ot", "<CMD>LazyDoToggle<CR>", mode = { "n" } },
    },
    opts = {
      -- your config here
    },
  },
}
