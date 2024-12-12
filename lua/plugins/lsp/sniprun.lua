---@type LazySpec
return {
  { import = "astrocommunity.code-runner.sniprun" },
  {
    "michaelb/sniprun",
    keys = {
      { "<Leader>rr", "<Plug>SnipRun", mode = { "n", "v" }, desc = "" },
      { "<Leader>rf", "<Plug>SnipRunOperator", mode = { "n", "v" }, desc = "" },
    },
  },
}
