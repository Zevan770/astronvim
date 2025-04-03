-- customize mason plugins
local suggested_packages = {}

local disable_auto_install = function(_, opts)
  local core = require "astrocore"
  local data_dir = vim.fn.stdpath "data"
  core.list_insert_unique(suggested_packages, opts.ensure_installed or {})
  local f = io.open(data_dir .. "/suggested-pkgs.json", "w")
  f:write(vim.fn.json_encode(suggested_packages))
  f:close()

  opts.ensure_installed = {}
end

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = disable_auto_install,
  },
}
