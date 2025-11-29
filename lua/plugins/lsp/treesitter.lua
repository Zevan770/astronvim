vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").pest = {
      install_info = {
        url = "https://github.com/pest-parser/tree-sitter-pest", -- local path or git repo
        -- files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        revision = "c19629a0c50e6ca2485c3b154b1dde841a08d169",
        queries = "queries", -- symlink queries from given directory
      },
      maintainers = { "@huacnlee" },
      tier = 2,
    }
  end,
})
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts) vim.treesitter.language.register("bash", "zsh") end,
}
