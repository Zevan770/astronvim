---@type LazySpec
return {
  {
    "chomosuke/term-edit.nvim",
    -- enabled = false,
    event = "TermOpen",
    opts = { prompt_end = "❯ " },
    version = "1.*",
  },

  {
    "xb-bx/editable-term.nvim",
    event = "TermOpen",
    enabled = false,
    opts = {
      promts = {
        ["^%(gdb%) "] = {}, -- gdb promt
        ["^>>> "] = {}, -- python PS1
        ["^... "] = {}, -- python PS2
        ["╰─ "] = {},
        ["❯ "] = {},
        -- ["some_other_prompt"] = {
        --   keybinds = {
        --     clear_current_line = "keys to clear the line",
        --     goto_line_start = "keys to goto line start",
        --     forward_char = "keys to move forward one character",
        --   },
        -- },
        wait_for_keys_delay = 50,
      },
    },
  },
}
