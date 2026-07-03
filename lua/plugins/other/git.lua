-- if true then return {} end
---@type LazySpec
return {
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
    keys = {
      { mode = { "n", "v" }, "<Leader>gy", "<Cmd>GitLink<CR>", desc = "Git link copy" },
      { mode = { "n", "v" }, "<Leader>go", "<Cmd>GitLink!<CR>", desc = "Git link open" },
    },
    config = function()
      require("gitlinker").setup {
        router = {
          browse = {
            ["^ssh%.github%.com"] = "https://github.com/"
              .. "{_A.ORG}/"
              .. "{_A.REPO}/blob/"
              .. "{_A.REV}/"
              .. "{_A.FILE}?plain=1"
              .. "#L{_A.LSTART}"
              .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          },
          blame = {
            ["^ssh%.github%.com"] = "https://github.com/"
              .. "{_A.ORG}/"
              .. "{_A.REPO}/blame/"
              .. "{_A.REV}/"
              .. "{_A.FILE}?plain=1"
              .. "#L{_A.LSTART}"
              .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          },
        },
      }
    end,
  },
  {
    "NeogitOrg/neogit",
    -- event = function() return {} end,
    ---@module "neogit"
    ---@type NeogitConfig
    event = "User AstroGitFile",
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(opts, {
        disable_builtin_notifications = true,
        telescope_sorter = function()
          if utils.is_available "telescope-fzf-native.nvim" then
            return require("telescope").extensions.fzf.native_fzf_sorter()
          end
        end,
        integrations = {
          telescope = utils.is_available "telescope.nvim",
          diffview = utils.is_available "diffview.nvim",
          fzf_lua = utils.is_available "fzf-lua",
          mini_pick = utils.is_available "mini.pick",
          snacks = utils.is_available "snacks.nvim",
          codediff = utils.is_available "codediff",
        },
        -- kind = "floating",
        graph_style = "unicode",
        diff_viewer = "codediff",
        disable_commit_confirmation = true,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      -- HACK: AstroNvim 用的竖线表示删掉的行不清晰，改为使用 gitsigns 默认的下划线形式
      opts.signs.delete = nil
      opts.signs.topdelete = nil
      opts.signs_staged.delete = nil
      opts.signs_staged.topdelete = nil
    end,
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
        diff = {
          ignore_trim_whitespace = true, -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
          hide_merge_artifacts = true,
        },
        conflict = {
          enabled = true,
          show_actions = true,
          keymaps = {
            ours = "1",
            theirs = "2",
            both = "3",
            none = "4",
            next = ")",
            prev = "(",
          },
        },
        intra = {
          algorithm = "codediff",
        },
        extra_filetypes = {
          "diff",
        },
      }
    end,
  },
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {},
  },
  {
    "titouancreach/review.nvim",
    branch = "fix/focus-steal-and-explorer-keymaps",
    dependencies = {
      "esmuellert/codediff.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Review" },
    keys = {
      { "<leader>gv", "<cmd>Review<cr>", desc = "Review" },
      { "<leader>gV", "<cmd>Review commits<cr>", desc = "Review commits" },
    },
    opts = {},
  },
  {
    "Cannon07/code-preview.nvim",
    enabled = false,
    config = function() require("code-preview").setup() end,
  },
}
