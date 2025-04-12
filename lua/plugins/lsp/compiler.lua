if true then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.code-runner.compiler-nvim" },
  {
    "Zeioth/compiler.nvim",
    opts = {},
  },
}
