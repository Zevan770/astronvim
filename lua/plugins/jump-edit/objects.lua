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
    "nvim-treesitter/nvim-treesitter-textobjects",
    keys = {
      {
        "<Leader>ial",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")

          local ft = vim.bo.filetype
          local indent = vim.api.nvim_get_current_line():match "^%s*"
          local ln = vim.api.nvim_win_get_cursor(0)[1]

          if ft == "python" then
            indent = indent .. (" "):rep(4)
            vim.api.nvim_buf_set_lines(0, ln, ln, false, { indent .. ('"'):rep(6) })
            vim.api.nvim_win_set_cursor(0, { ln + 1, #indent + 3 })
            vim.cmd.startinsert()
          elseif ft == "javascript" then
            vim.cmd.normal { "t)", bang = true } -- go to parameter, since cursor has to be on diagnostic for code action
            vim.lsp.buf.code_action {
              filter = function(action) return action.title == "Infer parameter types from usage" end,
              apply = true,
            }
            -- goto docstring (deferred, so code action can finish first)
            vim.defer_fn(function()
           	  vim.api.nvim_win_set_cursor(0, { ln + 1, 0 })
              vim.cmd.normal { "t)", bang = true }
            end, 100)
          elseif ft == "typescript" then
            -- add TSDoc
            vim.api.nvim_buf_set_lines(0, ln - 1, ln - 1, false, { indent .. "/**  */" })
            vim.api.nvim_win_set_cursor(0, { ln, #indent + 4 })
            vim.cmd.startinsert()
          elseif ft == "lua" then
            local paramLine = vim.api.nvim_get_current_line():match "function.*%((.*)%)$"
            if not paramLine then return end
            local params = vim.split(paramLine, ", ?")
            local luadocLines = vim
              .iter(params)
           	  :map(function(param) return ("%s---@param %s any"):format(indent, param) end)
           	  :totable()
            vim.api.nvim_buf_set_lines(0, ln - 1, ln - 1, false, luadocLines)
            -- goto 1st param type & edit it
            vim.api.nvim_win_set_cursor(0, { ln, #luadocLines[1] })
            vim.cmd.normal { '"_ciw', bang = true }
            vim.cmd.startinsert { bang = true }
          else
            vim.notify(ft .. " is not supported.", vim.log.levels.WARN, { title = "docstring" })
          end
        end,
      },
    },
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
          "im",
          "am",
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
