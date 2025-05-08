---@diagnostic disable: duplicate-set-field
-- init with some executable that are asserted to be available
local M = {}
M.executable_cache = {
  btm = 0,
  cc = 1,
  chafa = 1,
  cmake = 1,
  curl = 1,
  fd = 1,
  file = 1,
  gdu = 0,
  git = 1,
  ["im-select.exe"] = 1,
  lazygit = 1,
  less = 1,
  make = 1,
  ["mcp-hub"] = 1,
  node = 1,
  prettier = 1,
  python = 1,
  rg = 1,
  ["tree-sitter"] = 1,
  ["wezterm.exe"] = 1
}
function M.executable(cmd)
  -- cache it
  if M.executable_cache[cmd] == nil then M.executable_cache[cmd] = vim.fn.executable0(cmd) end
  return M.executable_cache[cmd]
end

function M.setup() vim.fn.executable = M.executable end

return M
