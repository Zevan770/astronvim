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
    -- enabled = false,
  },
  {
    "folke/noice.nvim",
    -- enabled = false,
    opts = function(self, opts)
      local presets = assert(opts.presets)
      presets.inc_rename = true
      presets.bottom_search = false
    end,
    -- stylua: ignore
    keys = {
      { "<leader>fnl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>fnh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>fna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>fnd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>fnt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    }
,
  },
}
