---@type LazySpec
return {

  {
    "nvim-zh/colorful-winsep.nvim",
    -- enabled = false,
    config = function(_, opts) require("colorful-winsep").setup() end,
    opts = {
      -- highlight for Window separator
      hi = {
        link = "FloatBorder",
      },
      -- This plugin will not be activated for filetype in the following table.
      no_exec_files = {
        "packer",
        "TelescopePrompt",
        "mason",
        "NvimTree",
      },
      -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
      -- symbols = vim.g.winborder == "single" and { "─", "│", "┌", "┐", "└", "┘" }
      --   or { "─", "│", "╭", "╮", "╰", "╯" },
      -- Smooth moving switch
      smooth = false,
      border = "bold",
      zindex = 100,
      anchor = {
        left = { height = 1, x = -1, y = -1 },
        right = { height = 1, x = -1, y = 0 },
        up = { width = 0, x = -1, y = 0 },
        bottom = { width = 0, x = 1, y = 0 },
      },
    },
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
