if true then return {} end
---@type LazySpec
return {
  {
    "oskarrrrrrr/symbols.nvim",
    event = "User AstroFile",
    config = function()
      local r = require "symbols.recipes"
      require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
        sidebar = {
          -- custom settings here
          -- e.g. hide_cursor = false
        },
      })
    end,
    keys = {
      { "<leader>lys", "<cmd>Symbols<CR>", mode = "n" },
    },
  },
}
