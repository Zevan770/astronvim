return {
  {
    "echasnovski/mini.move",
    event = "User AstroFile",
    version = false,
    -- No need to copy this inside `setup()`. Will be used automatically.
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- Created for both Normal and Visual modes.
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- Move current line in Normal mode
        line_left = "",
        line_right = "",
        line_down = "",
        line_up = "",
      },
    },
  },
}
