if vim.g.neovide or vim.fn.has "win32" == 1 then return {} end
---@type LazySpec
return {
  { "AstroNvim/astrocommunity", { import = "astrocommunity.media.image-nvim" } },
  {
    "3rd/image.nvim",
    enabled = false,
    opts = {
      backend = "ueberzug",
    },
  },
}
