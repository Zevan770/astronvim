local M = {}

M.key = require "utils.key"

M.is_windows = vim.fn.has "win32" == 1
M.is_android = vim.fn.has "android" == 1
M.is_nixos = not not os.getenv "NIX_PATH"
M.is_neovide = vim.g.neovide
M.is_vscode = vim.g.vscode
M.is_firenvim = vim.g.started_by_firenvim
M.is_server = false
M.blink_enabled = true
M.my_animate = "neoscroll"
-- M.autopair = "blink"
---@type "render"|"markview"
M.markdown_render = "render"

M.setup = function()
  _G.my_utils = M

  _G.switch = function(param, case_table)
    local case = case_table[param]
    if case then return case() end
    local def = case_table["default"]
    return def and def() or nil
  end
end

return M
