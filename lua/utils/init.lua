function MyFunction()
  -- 这里是你的代码
  print "Operator-pending mode activated"
end
vim.api.nvim_set_keymap("o", "zf", ":<C-U>lua MyFunction()<CR>", { noremap = true, silent = true })
