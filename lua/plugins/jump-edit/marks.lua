return {
  "chentoast/marks.nvim",
  event = "User AstroFile",
  opts = {
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
