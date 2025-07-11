return {
  {
    "mtrajano/tssorter.nvim",
    version = "*",
    opts = {},
    keys = {
      {
        "<leader>is",
        function() require("tssorter").sort {} end,
        mode = { "n", "x" },
        desc = "sort selected treesitter nodes.",
      },
      {
        "<leader>iS",
        function() require("tssorter").sort { reverse = true } end,
        mode = { "n", "x" },
        desc = "sort selected treesitter nodes (reversed).",
      },
    },
  },
}
