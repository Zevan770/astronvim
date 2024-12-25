---@type LazySpec
return {
  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.gitlinker-nvim" },
  { import = "astrocommunity.git.octo-nvim" },
  {
    "NeogitOrg/neogit",
    ---@type NeogitConfig
    opts = {
      kind = "floating",
      graph_style = "unicode",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = true,
        virt_text_priority = 1,
        use_focus = true,
      },
    },
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
}
