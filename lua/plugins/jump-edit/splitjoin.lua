---@type LazySpec
return {
  "AndrewRadev/splitjoin.vim",
  enabled = false,
  keys = {
    {
      "gJ",
      "<Plug>SplitjoinJoin",
      mode = { "n", "v" },
      remap = true,
    },
    {
      "gS",
      "<Plug>SplitjoinSplit",
      mode = { "n", "v" },
      remap = true,
    },
  },
}
