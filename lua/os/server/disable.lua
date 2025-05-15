local M = {}
local disabled = {
  "obsidian.nvim",
  "codecompanion.nvim",
  "copilot.lua",
  "blink-copilot",
  "mcphub.nvim",
  "avante.nvim",
  "im-select.nvim",
  "smear-cursor.nvim",
  "neoscroll.nvim",
}

-- mix disabled with "enabled = false"
for _, plugin in ipairs(disabled) do
  table.insert(M, {
    plugin,
    enabled = false,
  })
end
return M
