---@type LazySpec
return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    enabled = false,
    config = true,
    keys = {
      { "<leader>I", '<Cmd>lua require"incline".toggle()<Cr>', desc = "Incline: Toggle" },
    },
  },
}
