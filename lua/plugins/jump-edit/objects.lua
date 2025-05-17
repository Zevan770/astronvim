---@type LazySpec
return {
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    event = "User AstroFile",
    opts = {
      forwardLooking = { small = 5, big = 15 },
      keymaps = {
        useDefaults = true,
        disabledDefaults = {
          "n",
          "r",
          "R",
          "L",
          "Q",
          "in",
          "an",
          "ig",
          "ag",
          "i,",
          "a,",
        },
      },
      notify = {
        whenObjectNotFound = true,
      },
    },
  },
  {

    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(
        opts,
        ---@module "nvim-treesitter"
        ---@type TSConfig
        {
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "g<space>",
              node_incremental = "<c-l>",
              scope_incremental = "<c-j>",
              node_decremental = "<c-h>",
            },
          },
        }
      )
    end,
  },
}
