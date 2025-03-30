return {
  "gbprod/substitute.nvim",
  config = function(_, opts)
    require("substitute").setup(opts)
    -- Lua
    vim.keymap.set("n", "S", require("substitute").operator, { noremap = true })
    vim.keymap.set("n", "SS", require("substitute").line, { noremap = true })
    -- vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
    vim.keymap.set("x", "S", require("substitute").visual, { noremap = true })
  end,

  opts = {
    on_substitute = nil,
    yank_substituted_text = false,
    preserve_cursor_position = false,
    modifiers = nil,
    highlight_substituted_text = {
      enabled = true,
      timer = 500,
    },
    range = {
      prefix = "s",
      prompt_current_text = false,
      confirm = false,
      complete_word = false,
      subject = nil,
      range = nil,
      suffix = "",
      auto_apply = false,
      cursor_position = "end",
    },
    exchange = {
      motion = false,
      use_esc_to_cancel = true,
      preserve_cursor_position = false,
    },
  },
}
