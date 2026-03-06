-- if true then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.git.neogit" },
  -- { import = "astrocommunity.git.fugit2-nvim" },
  -- {
  --   "SuperBo/fugit2.nvim",
  --   build = false,
  --   opts = {},
  -- },
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
          maps[mode]["<Leader>go"] = { "<Cmd>GitLink!<CR>", desc = "Git link open" }
        end
      end,
    },
    opts = {},
  },
  {
    "NeogitOrg/neogit",
    -- event = function() return {} end,
    ---@module "neogit"
    ---@type NeogitConfig
    opts = {
      -- kind = "floating",
      graph_style = "unicode",
      integrations = {
        telescope = false,
        fzf_lua = false,
        snacks = true,
        codediff = true,
        diffview = false,
      },
      diff_viewer = "codediff",
      disable_commit_confirmation = true,
      disable_signs = false,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    -- enabled = false,
    opts = {
      debug_mode = false,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = true,
        virt_text_priority = 20,
        use_focus = true,
      },
    },
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>gn"] = { "<Cmd>Neogit<CR>", desc = "Open Neogit Tab Page" }
    end,
  },
  {
    "barrettruth/diffs.nvim",
    -- enabled = false,
    init = function()
      vim.g.diffs = {
        integrations = {
          fugitive = false,
          neogit = true,
          gitsigns = true,
        },
        conflict = {
          enabled = true,
          show_actions = true,
          keymaps = {
            ours = "dpo",
            theirs = "dpt",
            both = "dpb",
            none = "dpn",
            next = "]c",
            prev = "[c",
          },
        },
        intra = {
          algorithm = "codediff",
        },
      }
    end,
  },
  {
    "esmuellert/codediff.nvim",
    opts = {},
  },
  -- { import = "astrocommunity.git.diffview-nvim" },
}
