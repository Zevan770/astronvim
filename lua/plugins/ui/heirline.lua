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
    dependencies = { "Zeioth/heirline-components.nvim" },
    opts = function(self, opts)
      local status = require "astroui.status"
      opts.statusline[9] = require("astroui.status").component.lsp { lsp_progress = false }
      -- local components = require "heirline-components.all"
      -- table.insert(opts.statusline, 10, components.component.file_encoding()) -- after file_info component
      -- opts.statuscolumn = {
      --   init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      --   status.component.numbercolumn(),
      --   status.component.signcolumn(),
      --   status.component.foldcolumn(),
      -- }
    end,
  },
}
