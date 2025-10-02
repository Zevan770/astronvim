---@type LazySpec
return {
  {
    "RRethy/nvim-treesitter-textsubjects",
    config = function(self, opts)
      require("nvim-treesitter-textsubjects").configure {
        prev_selection = "?",
        keymaps = {
          ["i/"] = "textsubjects-smart",
          ["a;"] = "textsubjects-container-outer",
          ["i;"] = "textsubjects-container-inner",
        },
      }
    end,
  },
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
              -- peek_definition_code = {
              --   ["<leader>lpf"] = "@function.outer",
              --   ["<leader>lpc"] = "@class.outer",
              -- },
            },
            select = {
              enable = false,
            },
            move = {
              enable = false,
            },
            swap = {
              enable = true,
              swap_next = {
                [">K"] = { query = "@block.outer", desc = "Swap next block" },
                [">F"] = { query = "@function.outer", desc = "Swap next function" },
                [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
              },
              swap_previous = {
                ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
                ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
                ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
              },
            },
          },
          incremental_selection = {
            enable = false,
            keymaps = {
              init_selection = "<a-o>",
              node_incremental = "<a-o>",
              scope_incremental = "is",
              node_decremental = "<a-i>",
            },
          },
        }
      )
    end,
  },
  {
    "kana/vim-textobj-user",
  },
  {
    "preservim/vim-textobj-sentence",
    init = function()
      vim.cmd [[
      augroup textobj_sentence
        autocmd!
        autocmd FileType markdown call textobj#sentence#init()
        autocmd FileType textile call textobj#sentence#init()
      augroup END
      ]]
    end,
  },
  {
    "kana/vim-textobj-datetime",
    keys = function()
      local keys = { "ada", "add", "adf", "adt", "adz", "ida", "idd", "idf", "idt", "idz" }
      local res = {}
      for _, key in ipairs(keys) do
        table.insert(res, { mode = { "o", "x" }, key })
      end
      return res
    end,
  },
  -- {
  --   "jceb/vim-textobj-uri",
  --   event = "User AstroFile",
  -- },
  {
    "tommcdo/vim-ninja-feet",
    event = "User AstroFile",
    dev = true,
  },
}
