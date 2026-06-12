vim.b.minisurround_config = {
  custom_surroundings = {
    s = {
      input = { "%[%[().-()%]%]" },
      output = { left = "[[", right = "]]" },
    },
  },
}

vim.keymap.set("ia", "fnn", "function", { buffer = true })
