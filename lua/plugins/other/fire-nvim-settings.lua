if not vim.g.started_by_firenvim then return {} end

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   command = "set filetype=markdown",
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*kimi*", -- 这里的模式应匹配kimi相关的网址
--   command = "quit", -- 匹配时执行退出命令
-- })

local M = {}
local disabled = {
  "folke/noice.nvim",
  "rebelot/heirline.nvim",
  "wallpants/ghost-text.nvim",
  "codeium.nvim",
}

-- mix disabled with "enabled = false"
for _, plugin in ipairs(disabled) do
  table.insert(M, {
    plugin,
    enabled = false,
  })
end
---@type LazySpec
return M
