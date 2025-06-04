---@type LazySpec
return {
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    event = "User AstroFile",
    ---@module "various-textobjs"
    ---@type VariousTextobjs.Config
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
          ".",
          "g;",
          "!",
          "iq",
          "aq",
        },
      },
      notify = {
        whenObjectNotFound = true,
      },
      textobjs = {
        indentation = {
          -- `false`: only indentation decreases delimit the text object
          -- `true`: indentation decreases as well as blank lines serve as delimiter
          blanksAreDelimiter = false,
        },
        subword = {
          -- When deleting the start of a camelCased word, the result should
          -- still be camelCased and not PascalCased (see #113).
          noCamelToPascalCase = true,
        },
        diagnostic = {
          wrap = true,
        },
        url = {
          patterns = {
            [[%l%l%l+://[^%s)%]}"'`>]+]],
          },
        },
      },
    },
    keys = {},
  },
  {

    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(
        opts,
        ---@module "nvim-treesitter"
        ---@type TSConfig
        {
          textobjects = {
            lsp_interop = {
              enable = true,
              border = "none",
              floating_preview_opts = {},
              peek_definition_code = {
                ["<leader>lpf"] = "@function.outer",
                ["<leader>lpc"] = "@class.outer",
              },
            },
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              -- init_selection = "g<space>",
              node_incremental = "<a-o>",
              scope_incremental = "is",
              node_decremental = "<a-i>",
            },
          },
        }
      )
    end,
  },
}
