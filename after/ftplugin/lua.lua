vim.b.minisurround_config = {
  custom_surroundings = {
    s = {
      input = { "%[%[().-()%]%]" },
      output = { left = "[[", right = "]]" },
    },
  },
}

vim.cmd [[
iabbr <buffer> fn function
]]
