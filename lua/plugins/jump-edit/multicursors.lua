return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  enabled = false,
  dependencies = { "nvimtools/hydra.nvim" },
  config = true,
  opts = {},
  keys = {
    {
      mode = { "v", "n" },
      "<Leader>m",
      "<Cmd>MCstart<CR>",
      desc = "Create a selection for word under the cursor",
    },
  },
}
