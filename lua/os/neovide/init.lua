if not vim.g.neovide then return {} end

local M = {}
local disabled = {
  -- "neoscroll.nvim",
}

-- mix disabled with "enabled = false"
for _, plugin in ipairs(disabled) do
  table.insert(M, {
    plugin,
    enabled = false,
  })
end
return M
-- vim.g.neovide_cursor_vfx_mode = "pixiedust"
