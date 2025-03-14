return {
  "cbochs/portal.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<M-o>"] = { "<Cmd>Portal jumplist backward<CR>", desc = "Portal Jump backward" },
            ["<M-i>"] = { "<Cmd>Portal jumplist forward<CR>", desc = "Portal Jump forward" },
          },
        },
      },
    },
  },
  cmd = "Portal",
  opts = {},
}
