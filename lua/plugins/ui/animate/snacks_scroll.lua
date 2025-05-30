---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      scroll = {
        enabled = true,
        animate_repeat = {
          delay = 100, -- delay in ms before using the repeat animation
          duration = { step = 3, total = 25 },
        },
      },
    },
  },
}
