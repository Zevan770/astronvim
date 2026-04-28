---@diagnostic disable: missing-fields
-- if true then return {} end
---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  ---@type ToggleTermConfig
  init = function(self) _G.TTerm = require "toggleterm" end,
  opts = {
    direction = "float",
    float_opts = {
      -- winblend = 30,
    },
  },
}
