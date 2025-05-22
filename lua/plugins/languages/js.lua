if vim.fn.has "win32" == 1 then return {} end

---@type LazySpec
return {
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.tailwindcss" },
  -- tailwind-tools.lua
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    ft = function() return vim.tbl_get(require("astrocore").plugin_opts "astrolsp", "config", "vtsls", "filetypes") end,
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    ---@type TailwindTools.Option
    opts = {}, -- your configuration
  },
}
