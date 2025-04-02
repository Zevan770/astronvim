return {
  "Saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@param opts blink.cmp.Config
  opts = function(_, opts)
    opts.keymap = {
      preset = "super-tab",
      ["<C-y>"] = { "select_and_accept" },
    }

    opts.cmdline = { enabled = true }
    -- opts.completion = {
    --   menu = {
    --     auto_show = true,
    --   },
    -- }
  end,
}
