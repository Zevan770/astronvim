return {
  {
    "Saghen/blink.cmp",
    build = "cargo build --release",
    enabled = my_utils.blink_enabled,
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
        completion = {
          menu = { auto_show = true },
          trigger = {
            -- show_on_x_blocked_trigger_characters = { "'", '"', "(", "{", "!" },
          },
        },
      }
    end,
  },
  {
    "Saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          cmdline = {
            -- fix wsl stuck on cmdline completion
            enabled = function() return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match "^[%%0-9,'<>%-]*!" end,
          },
          lsp = {
            override = {
              get_trigger_characters = require("utils.blink").get_trigger_characters,
            },
          },
          buffer = {
            override = {
              get_trigger_characters = require("utils.blink").get_trigger_characters,
            },
          },
        },
      },
      signature = {
        window = {
          winblend = 10,
        },
      },
      completion = {
        menu = {
          max_height = 15,
          winblend = 10,
        },
        documentation = {
          window = {
            winblend = 10,
          },
        },
        list = {
          selection = {
            preselect = true,
          },
        },
        trigger = {
          show_on_blocked_trigger_characters = {},
        },
      },
      term = {
        enabled = true,
      },
      keymap = {
        ["<a-a>"] = {
          function()
            -- invoke manually, requires blink >v0.8.0
            require("blink-cmp").show { providers = { "lsp" } }
          end,
        },
      },
    },
  },
}
