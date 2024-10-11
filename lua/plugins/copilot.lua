---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.completion.copilot-cmp" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  -- { import = "astrocommunity.completion.avante-nvim" },
  -- { import = "astrocommunity.editing-support.copilotchat-nvim" },
  {
    "yetone/avante.nvim",
    build = ":AvanteBuild",
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
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = "<Leader>ai"

          maps.n[prefix] = { desc = "Avante functionalities" }

          maps.n[prefix .. "o"] = { function() require("avante.api").ask() end, desc = "Avante ask" }
          maps.v[prefix .. "o"] = { function() require("avante.api").ask() end, desc = "Avante ask" }

          maps.v[prefix .. "r"] = { function() require("avante.api").refresh() end, desc = "Avante refresh" }

          maps.n[prefix .. "e"] = { function() require("avante.api").edit() end, desc = "Avante edit" }
          maps.v[prefix .. "e"] = { function() require("avante.api").edit() end, desc = "Avante edit" }

          -- -- the following key bindings do not have an official api implementation
          -- maps.n.co = { "<Cmd>AvanteConflictChooseOurs<CR>", desc = "Choose ours" }
          -- maps.v.co = { "<Cmd>AvanteConflictChooseOurs<CR>", desc = "Choose ours" }
          --
          -- maps.n.ct = { "<Cmd>AvanteConflictChooseTheirs<CR>", desc = "Choose theirs" }
          -- maps.v.ct = { "<Cmd>AvanteConflictChooseTheirs<CR>", desc = "Choose theirs" }
          --
          -- maps.n.ca = { "<Cmd>AvanteConflictChooseAllTheirs<CR>", desc = "Choose all theirs" }
          -- maps.v.ca = { "<Cmd>AvanteConflictChooseAllTheirs<CR>", desc = "Choose all theirs" }
          --
          -- maps.n.c0 = { "<Cmd>AvanteConflictChooseNone<CR>", desc = "Choose none" }
          -- maps.v.c0 = { "<Cmd>AvanteConflictChooseNone<CR>", desc = "Choose none" }
          --
          -- maps.n.cb = { "<Cmd>AvanteConflictChooseBoth<CR>", desc = "Choose both" }
          -- maps.v.cb = { "<Cmd>AvanteConflictChooseBoth<CR>", desc = "Choose both" }
          --
          -- maps.n.cu = { "<Cmd>AvanteConflictChooseCursor<CR>", desc = "Choose cursor" }
          -- maps.v.cu = { "<Cmd>AvanteConflictChooseCursor<CR>", desc = "Choose cursor" }
          --
          -- maps.n["]x"] = { "<Cmd>AvanteConflictPrevConflict<CR>", desc = "Move to previous conflict" }
          -- maps.v["]x"] = { "<Cmd>AvanteConflictPrevConflict<CR>", desc = "Move to previous conflict" }
          --
          -- maps.n["[x"] = { "<Cmd>AvanteConflictNextConflict<CR>", desc = "Move to next conflict" }
          -- maps.x["[x"] = { "<Cmd>AvanteConflictNextConflict<CR>", desc = "Move to next conflict" }
        end,
      },
    },
    opts = {
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        --- @class AvanteConflictMappings
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
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
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
      -- {
      --   -- make sure `Avante` is added as a filetype
      --   "MeanderingProgrammer/render-markdown.nvim",
      --   optional = true,
      --   opts = function(_, opts)
      --     if not opts.file_types then opts.filetypes = { "markdown" } end
      --     opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "Avante" })
      --   end,
      -- },
      {
        -- make sure `Avante` is added as a filetype
        "OXY2DEV/markview.nvim",
        optional = true,
        opts = function(_, opts)
          if not opts.filetypes then opts.filetypes = { "markdown", "quarto", "rmd" } end
          opts.filetypes = require("astrocore").list_insert_unique(opts.filetypes, { "Avante" })
        end,
      },
    },
  },
}
