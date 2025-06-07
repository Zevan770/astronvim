local disabled = {}
vim.tbl_map(function(plugin) disabled[plugin] = true end, {
  "noice.nvim",
  "neoscroll.nvim",
  "heirline.nvim",
  "ghost-text.nvim",
  "codeium.nvim",
  "smear-cursor.nvim",
  "incline.nvim",
})

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return not disabled[plugin.name] end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.showtabline = 0
    vim.opt.laststatus = 0
  end,
})
vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline = "neovim",
      --content  = "text",
      --priority = 0,
      -- selector = "textarea",
      takeover = "never",
    },
  },
}
return {}
