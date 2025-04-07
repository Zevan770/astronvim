local M = {}

M.is_windows = vim.fn.has "win32" == 1
M.is_android = vim.fn.has "android" == 1
M.is_nixos = not not os.getenv "NIX_PATH"
M.is_neovide = vim.g.neovide
M.is_vscode = vim.g.vscode
M.is_firenvim = vim.g.started_by_firenvim

---@param modes any
---@param maps AstroCoreMappings
---@param group string
---@param new_group string
M.replace_group = function(modes, maps, group, new_group)
  if type(modes) == "string" then modes = { modes } end
  for _, mode in ipairs(modes) do
    for k, v in pairs(maps[mode]) do
      if k:find(group) then
        if new_group then maps[mode][k:gsub(group, new_group)] = v end
        maps[mode][k] = false
      end
    end
  end
end
_G.my_utils = M
return M
