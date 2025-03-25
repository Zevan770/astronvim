if true then return {} end
---@type LazySpec
return {
  { "AstroNvim/astrocommunity", { import = "astrocommunity.media.image-nvim" } },
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
    },
  },
}
