---@type LazySpec
return {
  "junegunn/vim-easy-align",
  event = "User AstroFile",
  keys = {
    {
      mode = { "n", "v" },
      "ga",
      "<Plug>(EasyA)ign)",
    },
    {
      mode = { "n", "v" },
      "gA",
      "<Plug>(LiveEasyAlign)",
    },
  },
}
