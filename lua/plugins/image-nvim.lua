if vim.fn.has "win32" then return {} end
---@type LazySpec
return {
  { "AstroNvim/astrocommunity", { import = "astrocommunity.media.image-nvim" } },
  -- {
  --   "3rd/image.nvim",
  --   opts = {
  --     backend = "ueberzug",
  --   },
  -- },
}
