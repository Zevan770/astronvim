---@type LazySpec
return {
  {
    "petertriho/nvim-scrollbar",
    enabled = false,
    opts = function(_, opts)
      require("astrocore").extend_tbl(opts, {
        handlers = {
          gitsigns = require("astrocore").is_available "gitsigns.nvim",
          search = require("astrocore").is_available "nvim-hlslens",
          ale = require("astrocore").is_available "ale",
        },
      })
    end,
    event = "User AstroFile",
  },
  {
    -- scrollbar
    "lewis6991/satellite.nvim",
    event = "User AstroFile",
    opts = {
      excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify", "neo-tree" },
      handlers = {
        marks = {
          enable = true,
          show_builtins = false, -- shows the builtin marks like [ ] < >
          key = "M",
        },
      },
    },
  },
}
