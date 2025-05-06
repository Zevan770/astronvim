return {
  {
    "Saghen/blink.cmp",
    build = "cargo build --release",
    ---@module 'blink.cmp'
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      opts.keymap = {
        preset = "super-tab",
        ["<C-y>"] = { "select_and_accept" },
      }

      opts.cmdline = {
        enabled = true,
        keymap = {
          preset = "inherit",
        },
        completion = { menu = { auto_show = true } },
      }
      -- opts.completion = {
      --   menu = {
      --     auto_show = true,
      --   },
      -- }
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "Kaiser-Yang/blink-cmp-git",
      },
    },
    opts = {
      sources = {
        -- add 'git' to the list
        default = { "git" },
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
            score_offset = -1,
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              prefix_min_len = 3,
              context_size = 5,
              max_filesize = "1M",
              -- Examples:
              -- - ".git" (default)
              -- - { ".git", "package.json", ".root" }
              project_root_marker = ".git",
              project_root_fallback = true,
              search_casing = "--ignore-case",
              additional_rg_options = {},
              fallback_to_regex_highlighting = true,
              ignore_paths = {},
              additional_paths = {},
              toggles = {
                on_off = "<Leader>uG",
              },
              future_features = {
                -- Workaround for
                -- https://github.com/mikavilpas/blink-ripgrep.nvim/issues/185. This
                -- is a temporary fix and will be removed in the future.
                issue185_workaround = false,
                backend = {
                  use = "ripgrep",
                },
              },
            },
          },
        },
      },
      keymap = {
        -- 👇🏻👇🏻 (optional) add a keymap to invoke the search manually
        ["<c-g>"] = {
          function()
            -- invoke manually, requires blink >v0.8.0
            require("blink-cmp").show { providers = { "ripgrep" } }
          end,
        },
      },
    },
  },
}
