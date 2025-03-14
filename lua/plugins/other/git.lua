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
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    version = "*",
    config = true,
    opts = {
      default_mappings = {
        ours = "o",
        theirs = "t",
        none = "0",
        both = "b",
        next = "n",
        prev = "p",
      },

      disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = "copen", -- command or function to open the conflicts list
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
  },
}
