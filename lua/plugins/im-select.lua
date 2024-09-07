-- don't load on android
if vim.fn.has "android" then return {} end
---@type LazySpec
return {
  "keaising/im-select.nvim",
  config = function()
    require("im_select").setup {
      async_switch_im = not vim.g.vscode,
    }
  end,
}
