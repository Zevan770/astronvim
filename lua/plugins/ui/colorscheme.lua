---@type LazySpec
return {
  -- color
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },

  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = {
      options = {
        module_default = false,
        modules = {
          aerial = true,
          cmp = true,
          ["dap-ui"] = true,
          dashboard = true,
          diagnostic = true,
          gitsigns = true,
          native_lsp = true,
          neotree = true,
          notify = true,
          symbol_outline = true,
          telescope = true,
          treesitter = true,
          whichkey = true,
        },
      },
      groups = { all = { NormalFloat = { link = "Normal" } } },
    },
  },
  {
    "catppuccin",
    lazy = true,
    ---@type CatppuccinOptions
    opts = {
      integrations = {
        noice = true,
        mini = true,
        -- indent_blankline = {
        --   enabled = true,
        --   colored_indent_levels = true,
        -- },
        navic = true,
        dropbar = true,
        grug_far = true,
        leap = true,
      },
    },
  },
}
