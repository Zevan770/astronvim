local snippet_path = vim.fn.stdpath "config" .. "/snippets"
return {
  {
    "chrisgrieser/nvim-scissors",
    event = "InsertEnter",
    opts = {
      snippetDir = snippet_path,
    },
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(...)
      require "astronvim.plugins.configs.luasnip"(...)
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { snippet_path },
      }
    end,
  },
}
