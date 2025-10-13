local disabled = {}
vim.tbl_map(function(plugin) disabled[plugin] = true end, {
  "obsidian.nvim",
  -- "codecompanion.nvim",
  -- "copilot.lua",
  -- "blink-copilot",
  "mcphub.nvim",
  "VectorCode",
  "avante.nvim",
  "im-select.nvim",
  "neoscroll.nvim",
})

local Config = require "lazy.core.config"
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return not disabled[plugin.name] end

return {}
