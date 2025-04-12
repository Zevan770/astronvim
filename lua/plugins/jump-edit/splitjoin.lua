if true then return {} end
---@type LazySpec

-- splitjoin类的插件
-- > - mature? [treesj](https://github.com/Wansmer/treesj) 成熟的？treesj
-- > - generic? [ts-node-action](https://github.com/CKolkey/ts-node-action/) 通用？ts-node-action
-- > - bramvim? [splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim) bramvim？splitjoin.vim
return {
  "AndrewRadev/splitjoin.vim",
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
