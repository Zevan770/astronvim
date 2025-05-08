---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts) vim.treesitter.language.register("bash", "zsh") end,
}
