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
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = true },
  -- { "savq/melange-nvim", lazy = true },
}
