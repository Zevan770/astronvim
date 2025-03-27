return {
  "Saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = function(_, opts)
    opts.keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
    }
    opts.completion = {
      menu = {
        auto_show = true,
      },
    }
  end,
}
