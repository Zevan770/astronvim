---@type LazySpec
return {
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  {
    "lervag/vimtex",
    lazy = true,
    ft = { "tex" },
    keys = {
      {
        "<localleader>lt",
        function() return require("vimtex.snacks").toc() end,
        ft = "tex",
      },
    },
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    lazy = true,
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      use_treesitter = true, -- whether to use treesitter to determine if cursor is in math mode; if false, vimtex is used
      allow_on_markdown = true, -- whether to add snippets to markdown filetype
    },
  },
}
