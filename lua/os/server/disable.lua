local M = {}
local disabled = {
  "obsidian.nvim",
  "codecompanion.nvim",
  "avante.nvim",
}

-- mix disabled with "enabled = false"
for _, plugin in ipairs(disabled) do
  table.insert(M, {
    plugin,
    enabled = false,
  })
end
return M
