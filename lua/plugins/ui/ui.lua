if true then return {} end
---@type LazySpec
return {
  {
    "OXY2DEV/ui.nvim",
    ---@module 'ui'
    ---@type ui.config
    opts = {
      cmdline = {
        enable = true,
      },
      popupmenu = {
        enable = false,
      },
    },
    lazy = false,
  },
  {
    "folke/noice.nvim",
    enabled = false,
  },
}
