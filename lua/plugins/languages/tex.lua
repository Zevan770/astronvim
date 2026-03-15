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
}
