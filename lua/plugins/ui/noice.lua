-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts.timeout = 500
      opts.render = "wrapped-compact"
      return opts
    end,
    enabled = false,
  },
  {
    "folke/noice.nvim",
    -- enabled = false,
    ---@param opts NoiceConfig
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(opts, {
        lsp = {
          hover = { enabled = false },
          signature = { enabled = false },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
        },
      })
    end,
    -- stylua: ignore
    keys = {
      { "<leader>anl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>anh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>ana", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>and", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>ant", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    }
,
  },
}
