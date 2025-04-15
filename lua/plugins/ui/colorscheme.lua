---@type LazySpec
return {
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
