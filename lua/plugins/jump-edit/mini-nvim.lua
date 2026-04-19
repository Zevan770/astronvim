--- echasnovski is just an brilian
---@type LazySpec
return {
  {
    "echasnovski/mini.surround",
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Surround = "󰑤" } } },
    },
    keys = { "go", "do", "co" },
    opts = function()
      local ts_input = require("mini.surround").gen_spec.input.treesitter
      return {
        n_lines = 50,
        mappings = {
          add = "go", -- Add surrounding in Normal modes
          delete = "do", -- Delete surrounding
          replace = "co", -- Replace surrounding
          find = "", -- Find surrounding (to the right)
          find_left = "", -- Find surrounding (to the left)
          highlight = "", -- Highlight surrounding
          update_n_lines = "", -- Update `n_lines`
          suffix_last = "", -- Suffix to search with "prev" method
          suffix_next = "", -- Suffix to search with "next" method
        },
        custom_surroundings = {
          f = {
            input = ts_input { outer = "@call.outer", inner = "@call.inner" },
          },
          ["c"] = {
            -- #region: https://github.com/echasnovski/mini.nvim/discussions/462
            output = function()
              -- is_visual doesn't work
              -- local is_visual = vim.tbl_contains({ 'v', 'V', '\22' }, vim.fn.mode())
              -- local mark_from = is_visual and "'<" or "'["
              -- local mark_to = is_visual and "'>" or "']"
              local mark_from = "'<"
              local mark_to = "'>"
              local startline = vim.fn.line(mark_from)
              local endline = vim.fn.line(mark_to)
              local n_content_lines = endline - startline
              if n_content_lines == 0 then return { left = "`", right = "`" } end
              local firstline = vim.api.nvim_buf_get_lines(0, startline - 1, startline, false)
              local _, indent = string.find(firstline[1], "^%s*")
              if indent ~= nil then
                return { left = "```\n" .. string.rep(" ", indent), right = "\n" .. string.rep(" ", indent) .. "```\n" }
              else
                return { left = "```\n", right = "\n```\n" }
              end
            end,
            -- #endregion:
          },
          ["8"] = {
            output = { left = "**", right = "**" },
          },
        },
      }
    end,
  },
  {
    "andymass/vim-matchup",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "doo", "<plug>(matchup-ds%)", noremap = true },
      { "coo", "<plug>(matchup-cs%)", remap = true },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              matchup_matchparen_nomode = "i",
              matchup_matchparen_deferred = 1,
              matchup_matchparen_offscreen = {},
              matchup_surround_enabled = true,
            },
          },
        },
      },
      {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "andymass/vim-matchup" },
        opts = { matchup = { enable = true } },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "User AstroFile",
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        mappings = {
          around_last = "ah",
          inside_last = "ih",
          around_next = "al",
          inside_next = "il",
        },
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          },
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
          c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" }, -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = "[%w_]" }, -- without dot in function name
          a = ai.gen_spec.treesitter { -- key
            a = { "@key.outer", "@parameter.outer" },
            i = { "@key.inner", "@parameter.inner" },
          },
          ["?"] = ai.gen_spec.treesitter { -- question mark
            a = { "@conditional.outer", "@loop.outer" },
            i = { "@conditional.inner", "@loop.inner" },
          },
          ["C"] = ai.gen_spec.treesitter { -- exclamation mark
            a = { "@call.outer" },
            i = { "@call.inner" },
          },
        },
      }
    end,
  },
  {
    "echasnovski/mini.align",
    event = "User AstroFile",
    opts = {},
  },
}
