---@type LazySpec
vim.keymap.set({ "n", "v" }, "ga", "<Plug>(EasyAlign)")
vim.keymap.set({ "n", "v" }, "gA", "<Plug>(LiveEasyAlign)")
return {
  "junegunn/vim-easy-align",
  event = "User AstroFile",
}
