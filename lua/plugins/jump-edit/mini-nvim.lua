--- echasnovski is just an brilian
---@type LazySpec
return {
  {
    "echasnovski/mini.surround",
    event = "User AstroFile",
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Surround = "󰑤" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["gs"] = { desc = require("astroui").get_icon("Surround", 1, true) .. "Surround" }
        end,
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
      vim.keymap.del("x", "yo")
    end,
    keys = function(plugin, keys)
      -- local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false) -- resolve mini.clue options
      -- Populate the keys based on the user's options
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
        { "S", ":<C-u>lua MiniSurround.add('visual')<CR>", mode = "x", silent = true },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = function()
      local ts_input = require("mini.surround").gen_spec.input.treesitter
      return {
        n_lines = 50,
        mappings = {
          add = "yo", -- Add surrounding in Normal modes
          delete = "do", -- Delete surrounding
          replace = "co", -- Replace surrounding
          find = "gsf", -- Find surrounding (to the right)
          find_left = "gsF", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          update_n_lines = "", -- Update `n_lines`
          suffix_last = "N", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },
        custom_surroundings = {
          f = {
            input = ts_input { outer = "@call.outer", inner = "@call.inner" },
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
      { "gsd%", "<plug>(matchup-ds%)", noremap = true },
      { "gsc%", "<plug>(matchup-cs%)", remap = true },
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
          around_next = "an",
          inside_next = "in",
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
