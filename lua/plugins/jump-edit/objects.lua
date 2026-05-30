---@type LazySpec
return {
  {
    "RRethy/nvim-treesitter-textsubjects",
    enabled = false, -- TODO:disable util it supports nvim-treesitter main branch
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
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local t = {
        f = "@call",
        m = "@function",
      }
      local textobjects = opts.treesitter.textobjects
      -- for each key * in t, fill up textobjects keymap with a* i* [* ]* <* >*
      for key, query in pairs(t) do
        textobjects.select.select_textobject["a" .. key] = { query = query .. ".outer", desc = "around " .. query }
        textobjects.select.select_textobject["i" .. key] = { query = query .. ".inner", desc = "inside " .. query }
        textobjects.move.goto_next_start["]" .. key] =
          { query = query .. ".outer", desc = "Next " .. query .. " start" }
        textobjects.move.goto_next_end["]" .. string.upper(key)] =
          { query = query .. ".outer", desc = "Next " .. query .. " end" }
        textobjects.move.goto_previous_start["[" .. key] =
          { query = query .. ".outer", desc = "Previous " .. query .. " start" }
        textobjects.move.goto_previous_end["[" .. string.upper(key)] =
          { query = query .. ".outer", desc = "Previous " .. query .. " end" }
        textobjects.swap.swap_next[">" .. string.upper(key)] =
          { query = query .. ".outer", desc = "Swap next " .. query }
        textobjects.swap.swap_previous["<" .. string.upper(key)] =
          { query = query .. ".outer", desc = "Swap previous " .. query }
      end
    end,
  },
  {
    "kana/vim-textobj-user",
  },
  {
    "preservim/vim-textobj-sentence",
    enabled = false,
    init = function()
      vim.cmd [[
      augroup textobj_sentence
        autocmd!
        autocmd FileType markdown call textobj#sentence#init()
        autocmd FileType textile call textobj#sentence#init()
      augroup END
      ]]
      -- <./arrow.lua>
    end,
  },
  {
    "kana/vim-textobj-datetime",
    keys = function()
      -- 1976-09-09
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
