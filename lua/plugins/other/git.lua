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
      ---@param opts AstrocoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        for _, mode in ipairs { "n", "v" } do
          maps[mode]["<Leader>gy"] = { "<Cmd>GitLink<CR>", desc = "Git link copy" }
          maps[mode]["<Leader>gz"] = { "<Cmd>GitLink!<CR>", desc = "Git link open" }
        end
      end,
    },
    opts = {},
  },
  {
    "NeogitOrg/neogit",
    event = function() return {} end,
    ---@type NeogitConfig
    opts = {
      kind = "floating",
      graph_style = "kitty",
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

  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>gn"] = { "<Cmd>Neogit<CR>", desc = "Open Neogit Tab Page" }
    end,
  },
}
