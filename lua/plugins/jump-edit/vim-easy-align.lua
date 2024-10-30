---@type LazySpec
return {
  "junegunn/vim-easy-align",
  event = "User AstroFile",
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
