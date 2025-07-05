-- if true then return {} end
---@type LazySpec
return {
  -- {
  --   "rebelot/heirline.nvim",
  --   dependencies = "AstroNvim/astroui",
  --   opts = function(self, opts)
  --     local status = require "astroui.status"
  --     opts.statusline = { -- statusline
  --       hl = { fg = "fg", bg = "bg" },
  --       status.component.mode(),
  --       status.component.git_branch(),
  --       status.component.file_info(),
  --       status.provider.file_encoding(),
  --       status.component.git_diff(),
  --       status.component.diagnostics(),
  --       status.component.fill(),
  --       status.component.cmd_info(),
  --       status.component.fill(),
  --       status.component.lsp(),
  --       status.component.virtual_env(),
  --       status.component.treesitter(),
  --       status.component.nav(),
  --       status.component.mode { surround = { separator = "right" } },
  --     }
  --   end,
  -- },
  {
    "rebelot/heirline.nvim",
    dependencies = {
      "Zeioth/heirline-components.nvim",
    },
    opts = function(_, opts)
      local astroui = require "astroui.status"
      local components = require "heirline-components.all"

      opts.statusline[9] = require("astroui.status").component.lsp { lsp_progress = false }
      -- table.insert(opts.statusline, 10, components.component.compiler_state())
      -- table.insert(
      --   opts.statusline,
      --   6,
      --   status.component.breadcrumbs {
      --     icon = { hl = true },
      --   }
      -- )
      table.insert(
        opts.statusline,
        3,
        components.component.file_encoding {
          file_format = { padding = { left = 0, right = 1 } }, -- if set, displays the OS the current buffer is currently encoded for.
          file_encoding = { padding = { left = 0, right = 1 } }, -- if set, displays the encoding format the current buffer currently has.
        }
      )
      -- table.insert(opts.statusline, 6, components.component.breadcrumbs())
      -- table.insert(opts.statusline, 6, bar.navic())
      -- opts.winbar = nil
    end,
  },

  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      status = {
        icon_highlights = {
          breadcrumbs = true,
        },
        separators = {
          tab = { "", "" },
        },
      },
    },
  },

  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    enabled = false,
    config = true,
    keys = {
      { "<leader>I", '<Cmd>lua require"incline".toggle()<Cr>', desc = "Incline: Toggle" },
    },
  },
  -- navic
  {
    "SmiteshP/nvim-navic",
    enabled = false,
    opts = {
      lsp = {
        auto_attach = true,
      },
      highlight = true,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = false,
      click = true,
      format_text = function(text) return text end,
    },
  },
}
