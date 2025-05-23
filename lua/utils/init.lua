local M = {}

M.is_windows = vim.fn.has "win32" == 1
M.is_android = vim.fn.has "android" == 1
M.is_nixos = not not os.getenv "NIX_PATH"
M.is_neovide = vim.g.neovide
M.is_vscode = vim.g.vscode
M.is_firenvim = vim.g.started_by_firenvim
M.is_server = false
M.blink_enabled = true

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

M.dap_breakpoint = function()
  -- 获取当前缓冲区的所有错误诊断
  local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

  -- 获取nvim-dap模块
  local dap = require "dap"

  -- 遍历所有错误诊断并在相应行添加断点
  for _, diagnostic in ipairs(diagnostics) do
    local line = diagnostic.lnum
    dap.set_breakpoint(nil, nil, nil, { line = line + 1 }) -- 行号是0索引的，所以需要加1
  end
end

_G.my_utils = M
return M
