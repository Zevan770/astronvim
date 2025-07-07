---@diagnostic disable: missing-fields
-- if true then return {} end
---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  ---@type ToggleTermConfig
  opts = {
    direction = "float",
    float_opts = {
      -- winblend = 30,
    },
  },
}
