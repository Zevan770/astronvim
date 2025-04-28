---@type LazySpec
return {
  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.octo-nvim" },
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    dependencies = {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local prefix = "<Leader>g"
        opts.mappings.n[prefix .. "y"] = { "<Cmd>GitLink<CR>", desc = "Git link copy" }
        opts.mappings.n[prefix .. "z"] = { "<Cmd>GitLink!<CR>", desc = "Git link open" }
        opts.mappings.v[prefix .. "y"] = { "<Cmd>GitLink<CR>", desc = "Git link copy" }
        opts.mappings.v[prefix .. "z"] = { "<Cmd>GitLink!<CR>", desc = "Git link open" }
      end,
    },
    opts = {},
  },
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
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = true,
        virt_text_priority = 100,
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
  {
    "wintermute-cell/gitignore.nvim",
    cmd = "Gitignore",
    config = function() require "gitignore" end,
  },
}
