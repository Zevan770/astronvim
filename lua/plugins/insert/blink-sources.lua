if not my_utils.blink_enabled then return {} end
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
  -- {
  --   "saghen/blink.cmp",
  --   dependencies = { "yaocccc/blink-cmp-cmdlinehistory" },
  --   opts = {
  --     cmdline = {
  --       sources = { "clhistory", "cmdline" },
  --     },
  --     sources = {
  --       providers = {
  --         clhistory = {
  --           name = "history",
  --           module = "cmdlinehistory",
  --           score_offset = 999,
  --           opts = {
  --             fiexedkeyword = true, -- default
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "mgalliou/blink-cmp-tmux",
    enabled = not my_utils.is_windows,
    dependencies = {
      {
        "saghen/blink.cmp",
        dependencies = {
          "mgalliou/blink-cmp-tmux",
        },
        opts = {
          sources = {
            default = {
              "tmux",
            },
            providers = {
              tmux = {
                module = "blink-cmp-tmux",
                name = "tmux",
                score_offset = -100,
                -- default options
                opts = {
                  panes = "window",
                  capture_history = false,
                  triggered_only = false,
                  trigger_chars = { "." },
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
