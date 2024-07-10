---@type LazySpec
return {
  "junegunn/vim-easy-align",
  event = "User AstroFile",
  keys = {
    {
      "gA",
      "<Plug>(LiveEasyAlign)",
      desc = "align",
      mode = { "n", "v" },
    },
    {
      "ga",
      "<Plug>(EasyAlign)",
      desc = "align",
      mode = { "n", "v" },
    },
  },
}
