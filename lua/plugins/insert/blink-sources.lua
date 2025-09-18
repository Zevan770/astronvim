---@type LazySpec
return {
  {
    "Saghen/blink.cmp",
    dependencies = { "Kaiser-Yang/blink-cmp-git" },
    opts = {
      sources = {
        -- add 'git' to the list
        providers = {
          git = {
            module = "blink-cmp-git",
            name = "Git",
            -- only enable this source when filetype is gitcommit, markdown, or 'octo'
            enabled = function() return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype) end,
            --- @module 'blink-cmp-git'
            --- @type blink-cmp-git.Options
            opts = {
              -- options for the blink-cmp-git
            },
          },
        },
      },
    },
  },
  {
    "Saghen/blink.cmp",
    dependencies = { "mikavilpas/blink-ripgrep.nvim" },
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { "ripgrep" },
        providers = {
          -- 👇🏻👇🏻 add the ripgrep provider config below
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            score_offset = -99, --NOTE: score_offset is 0 by default
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              prefix_min_len = 3,
              fallback_to_regex_highlighting = true,
              project_root_marker = ".git",
              toggles = {
                on_off = "<Leader>ubg",
              },
              backend = {
                context_size = 5,
                use = "ripgrep",
                ripgrep = {
                  max_filesize = "1M",
                  project_root_fallback = true,
                  search_casing = "--ignore-case",
                  additional_rg_options = {},
                  ignore_paths = {},
                  additional_paths = {},
                },
              },
              future_features = {
                -- Workaround for
                -- https://github.com/mikavilpas/blink-ripgrep.nvim/issues/185 . This
                -- is a temporary fix and will be removed in the future.
                issue185_workaround = false,
              },
            },
          },
        },
      },
      keymap = {
        ["<a-g>"] = {
          function()
            -- invoke manually, requires blink >v0.8.0
            require("blink-cmp").show { providers = { "ripgrep" } }
          end,
        },
      },
    },
  },

  {
    "fang2hou/blink-copilot",
    dependencies = {
      {
        "saghen/blink.cmp",
        dependencies = { "fang2hou/blink-copilot" },
        opts = {
          sources = {
            default = { "copilot" },
            providers = {
              copilot = {
                name = "copilot",
                module = "blink-copilot",
                -- score_offset = 100,
                async = true,
                override = {
                  get_trigger_characters = require("utils.blink").get_trigger_characters,
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {
      sources = {
        -- Add 'dictionary' to the list
        -- default = { "dictionary" },
        providers = {
          dictionary = {
            module = "blink-cmp-dictionary",
            max_items = 8,
            score_offset = -100,
            name = "Dict",
            -- Make sure this is at least 2.
            -- 3 is recommended
            min_keyword_length = 3,
            --- @type blink-cmp-dictionary.Options
            opts = {
              dictionary_files = {
                vim.fn.expand "~/.config/english-words.txt",
              },
              toggles = {
                on_off = "<Leader>uBd",
              },
              -- options for blink-cmp-dictionary
            },
          },
        },
      },
    },
  },
}
