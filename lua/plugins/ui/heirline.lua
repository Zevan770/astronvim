-- if true then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.recipes.vscode-icons" },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      local cached_func = function(func, ...)
        local cached
        local args = { ... }
        return function(self)
          if cached == nil then cached = func(unpack(args)) end
          if type(cached) == "function" then return cached(self) end
          return cached
        end
      end

      opts.statusline[9] = require("astroui.status").component.lsp { lsp_progress = false }
      -- table.insert(opts.statusline, 10, components.component.compiler_state())
      -- table.insert(
      --   opts.statusline,
      --   6,
      --   astroui.component.breadcrumbs {
      --     icon = { hl = true },
      --   }
      -- )
      table.insert(
        opts.statusline,
        3,
        status.component.builder {
          { provider = "file_format", opts = { padding = { right = 1 } } },
          { provider = "file_encoding" },
        }
      )
      -- table.insert(opts.statusline, 6, components.component.breadcrumbs())
      -- table.insert(opts.statusline, 6, bar.navic())
      -- opts.winbar = nil

      opts.winbar = { -- winbar
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        fallthrough = false,
        {
          status.component.separated_path(),
          status.component.file_info {
            file_icon = { hl = cached_func(status.hl.file_icon, "winbar"), padding = { left = 0 } },
            filename = {},
            filetype = false,
            file_read_only = false,
            hl = cached_func(status.hl.get_attributes, "winbarnc", true),
            surround = false,
            update = { "BufEnter", "BufFilePost" },
          },
        },
        status.component.breadcrumbs { hl = cached_func(status.hl.get_attributes, "winbar", true) },
      }
    end,
  },

  -- { -- nicer-looking tabs with close icons
  --   "nanozuki/tabby.nvim",
  --   dependencies = { "echasnovski/mini.icons" },
  --   config = function() require("tabby.tabline").use_preset "tab_with_top_win" end,
  -- },

  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      status = {
        icon_highlights = {
          breadcrumbs = true,
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
