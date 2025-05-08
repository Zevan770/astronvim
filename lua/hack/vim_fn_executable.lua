---@diagnostic disable: duplicate-set-field
-- init with some executable that are asserted to be available
local executable_cache = {
  git = 1,
  lazygit = 1,
  btm = 0,
  rg = 1,
  make = 1,
  cmake = 1,
}

vim.fn.executable = function(cmd)
  -- cache it
  if executable_cache[cmd] == nil then executable_cache[cmd] = vim.fn.executable0(cmd) end
  return executable_cache[cmd]
end
