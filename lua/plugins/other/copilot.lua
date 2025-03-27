---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    -- { import = "astrocommunity.completion.copilot-lua" },
    -- { import = "astrocommunity.completion.copilot-cmp" },
    -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  -- { import = "astrocommunity.completion.avante-nvim" },
  -- { import = "astrocommunity.editing-support.copilotchat-nvim" },
  {
    "yetone/avante.nvim",
    build = ":AvanteBuild",
    -- init = function() vim.treesitter.language.register("markdown", "avante") end,
    cmd = {
      "AvanteAsk",
      "AvanteBuild",
      "AvanteConflictChooseAllTheirs",
      "AvanteConflictChooseBase",
      "AvanteConflictChooseBoth",
      "AvanteConflictChooseCursor",
      "AvanteConflictChooseNone",
      "AvanteConflictChooseOurs",
      "AvanteConflictChooseTheirs",
      "AvanteConflictListQf",
      "AvanteConflictNextConflict",
      "AvanteConflictPrevConflict",
      "AvanteEdit",
      "AvanteRefresh",
      "AvanteSwitchProvider",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts) opts.mappings.n["<Leader>ai"] = { desc = " Avante" } end,
      },
      {
        -- make sure `Avante` is added as a filetype
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        opts = function(_, opts)
          if not opts.file_types then opts.filetypes = { "markdown" } end
          opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "Avante" })
        end,
      },
      {
        -- make sure `Avante` is added as a filetype
        "OXY2DEV/markview.nvim",
        optional = true,
        opts = function(_, opts)
          if not opts.preview.filetypes then opts.preview.filetypes = { "markdown", "quarto", "rmd" } end
          opts.preview.filetypes = require("astrocore").list_insert_unique(opts.preview.filetypes, { "Avante" })
        end,
      },
    },
    ---@type avante.Config
    opts = {
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },
      mappings = {
        ask = "<leader>aia",
        edit = "<leader>aie",
        refresh = "<leader>air",
        focus = "<leader>aif",
        toggle = {
          default = "<leader>ait",
          debug = "<leader>aid",
          hint = "<leader>aih",
          suggestion = "<leader>ais",
          repomap = "<leader>aiR",
        },
        files = {
          add_current = "<leader>aic", -- Add current buffer to selected files
        },
        select_model = "<leader>ai?", -- Select model command
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<C-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        hints = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        mode = "n",
        "<leader>ai",
        desc = " Avante",
      },
    },
    specs = { -- configure optional plugins
      { -- if copilot.lua is available, default to copilot provider
        "zbirenbaum/copilot.lua",
        optional = true,
        specs = {
          {
            "yetone/avante.nvim",
            opts = {
              provider = "copilot",
            },
          },
        },
      },
    },
  },
}
