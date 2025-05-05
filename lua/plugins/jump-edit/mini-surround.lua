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
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = function()
      local ts_input = require("mini.surround").gen_spec.input.treesitter
      return {
        n_lines = 50,
        mappings = {
          add = "gsa", -- Add surrounding in Normal modes
          delete = "gsd", -- Delete surrounding
          find = "gsf", -- Find surrounding (to the right)
          find_left = "gsF", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          replace = "gsc", -- Replace surrounding
          update_n_lines = "gsn", -- Update `n_lines`
        },
        custom_surroundings = {
          f = {
            input = ts_input { outer = "@call.outer", inner = "@call.inner" },
          },
        },
      }
    end,
  },
}
