---@type LazySpec
return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    -- enabled = false,
    config = true,
    keys = {
      { "<leader>I", '<Cmd>lua require"incline".toggle()<Cr>', desc = "Incline: Toggle" },
    },
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },

  {
    "Bekaboo/deadcolumn.nvim",
    opts = {
      scope = "line", ---@type string|fun(): integer
      ---@type string[]|boolean|fun(mode: string): boolean
      modes = function(mode) return mode:find "^[iRss\x13]" ~= nil end,
      blending = {
        threshold = 0.5,
        -- colorcode = "#000000",
        hlgroup = { "Normal", "bg" },
      },
      warning = {
        alpha = 0.4,
        offset = 0,
        -- colorcode = "#FF0000",
        hlgroup = { "Error", "bg" },
      },
      extra = {
        ---@type string?
        follow_tw = nil,
      },
    },
  },
}
