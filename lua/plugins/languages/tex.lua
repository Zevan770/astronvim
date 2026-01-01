---@type LazySpec
return {
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  {
    "lervag/vimtex",
    keys = {
      {
        "<localleader>lt",
        function() return require("vimtex.snacks").toc() end,
        ft = "tex",
      },
    },
  },
}
