local M = {}

M.config = {
  default_register = "q", -- 默认宏寄存器
}

M.q = function()
  if vim.fn.reg_recording() ~= "" then
    -- 正在录制，结束录制
    vim.api.nvim_feedkeys("q", "n", false)
    return
  end
  local reg = vim.v.register
  -- 只允许 a-zA-Z 作为宏寄存器
  if not reg or not reg:match "^[a-zA-Z]$" then reg = M.config.default_register end
  vim.api.nvim_feedkeys("q" .. reg, "n", false)
end

--- NOTE: Nvim default:
--- * Q   play last recorded macro: reg_recorded()
--- * @@  play last played macro
--- what we do: default to play last played macro, else play v:register
M.play = function()
  local reg = vim.v.register
  -- 只允许 a-zA-Z 作为宏寄存器
  if not reg or not reg:match "^[a-zA-Z]$" then reg = "@" end
  vim.api.nvim_feedkeys("@" .. reg, "n", false)
end

return M
