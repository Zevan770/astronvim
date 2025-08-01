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
  { import = "astrocommunity.colorscheme.vim-moonfly-colors" },
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  {
    "RRethy/base16-nvim",
    enabled = false,
    config = function()
      require("base16-colorscheme").setup {
        -- base00 = '#16161D', base01 = '#2c313c', base02 = '#3e4451', base03 = '#6c7891',
        -- base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
        -- base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
        -- base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
      }
    end,
    -- lazy = true,
  },
  -- { import = "astrocommunity.recipes.vscode-icons" },
  {
    "marko-cerovac/material.nvim",
    lazy = true,
  },
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
    ---@module "catppuccin"
    ---@type CatppuccinOptions
    opts = {
      -- transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      no_bold = false,
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.35, -- percentage of the shade to apply to the inactive window
      },
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = { "italic" },
        strings = {},
        variables = { "bold" },
        numbers = {},
        booleans = {},
        properties = {},
        types = { "bold" },
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        alpha = true,
        avante = true,
        dadbod_ui = true,
        noice = true,
        mini = true,
        -- indent_blankline = {
        --   enabled = true,
        --   colored_indent_levels = true,
        -- },
        navic = true,
        dropbar = true,
        grug_far = true,
        lsp_trouble = true,
        leap = true,
        fidget = true,
        overseer = true,
        octo = true,
        snacks = {
          enabled = true,
          indent_scope_color = "pink", -- catppuccin color (eg. `lavender`) Default: text
        },
        markview = true,
        render_markdown = true,
        which_key = true,
      },
    },
  },
  { "dasupradyumna/midnight.nvim", lazy = true },
  -- { "sainnhe/everforest", lazy = true },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup {
        italics = true,
        ui_contrast = "high",
      }
    end,
  },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "UtkarshVerma/molokai.nvim", lazy = true },
  { "loctvl842/monokai-pro.nvim", lazy = true },
  -- { "savq/melange-nvim", lazy = true },
}
