if true then return {} end
---@type LazySpec
return {
  "Bekaboo/dropbar.nvim",
  event = "UIEnter",
  opts = function(_, opts)
    local utils = require "dropbar.utils"
    local sources = require "dropbar.sources"

    ---@type dropbar_configs_t
    return {
      bar = {
        sources = function(buf, _)
          if vim.bo[buf].ft == "markdown" then
            return {
              sources.path,
              sources.markdown,
            }
          end
          if vim.bo[buf].buftype == "terminal" then return {
            sources.terminal,
          } end
          return {
            sources.path,
            utils.source.fallback {
              sources.lsp,
              sources.treesitter,
            },
          }
        end,
      },
      sources = {
        path = {
          max_depth = 2,
        },
      },
      menu = {
        keymaps = {
          ["<A-l>"] = function()
            local menu = utils.menu.get_current()
            if not menu then return end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then menu:click_on(component, nil, 1, "l") end
          end,
        },
      },
    }
  end,
  dependencies = {
    {
      "rebelot/heirline.nvim",
      optional = true,
      opts = function(_, opts) opts.winbar = nil end,
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        maps.n["<Leader>j"] = { desc = "+Jump" }
        maps.n["<Leader>jv"] =
          { function() require("dropbar.api").select_next_context() end, desc = "breadcrumbs/dropbar" }
        maps.n["<Leader>jp"] = { function() require("dropbar.api").pick() end, desc = "breadcrumbs/dropbar" }
      end,
    },
  },
}
