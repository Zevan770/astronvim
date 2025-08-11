return {
  "chentoast/marks.nvim",
  enabled = false,
  event = "User AstroFile",
  opts = {
    -- force_write_shada = true,
    sign_priority = { lower = 2, upper = 3, builtin = 1, bookmark = 4 },
    excluded_buftypes = {
      "nofile",
      "terminal",
    },
    builtin_marks = { "'", "<", ">", "." },
    mappings = {
      preview = "',",
      delete_line = "dmm",
      annotate = "cm",
    },
    virt_text_pos = "eol",
    bookmark_1 = {
      sign = "⚑",
      virt_text = "flag",
      annotate = true,
    },
  },
}
