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
            enabled = function() return vim.fn.getcmdline():sub(1, 1) ~= "!" end,
          },
        },
      },
      completion = {
        list = {
          selection = {
            preselect = true,
          },
        },
      },
    },
  },
}
