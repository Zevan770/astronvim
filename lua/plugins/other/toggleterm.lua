---@diagnostic disable: missing-fields
-- if true then return {} end
---@type LazySpec
local esc_timer
return {
  "akinsho/toggleterm.nvim",
  ---@type ToggleTermConfig
  opts = {
    direction = "float",
    float_opts = {
      -- winblend = 30,
    },
  },
  keys = {
    {
      "<esc>",
      function()
        ---@diagnostic disable-next-line: inject-field
        esc_timer = esc_timer or vim.uv.new_timer()
        if esc_timer:is_active() then
          esc_timer:stop()
          vim.api.nvim_feedkeys(vim.keycode "a", "n", false) -- add this line for `--vim`
          vim.cmd "stopinsert"
        else
          esc_timer:start(200, 0, function() end)
          return "<esc>"
        end
      end,
      mode = "t",
      expr = true,
      desc = "Double escape to normal mode",
    },
  },
}
