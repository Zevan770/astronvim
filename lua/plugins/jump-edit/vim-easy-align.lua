if true then return {} end
---@type LazySpec
return {
  "junegunn/vim-easy-align",
  lazy = true,
  keys = {
    {
      mode = { "n", "v" },
      "ga",
      "<Plug>(EasyAlign)",
    },
    {
      mode = { "n", "v" },
      "gA",
      "<Plug>(LiveEasyAlign)",
    },
  },
}
