local M = {}
local disabled = {
  "image.nvim",
  "neotree.nvim",
  "mcphub.nvim",
  "vim-illuminate",
  -- "telescope.nvim",
  -- "neoscroll.nvim",
  -- "dropbar.nvim",
  -- "astrolsp",
  -- "im-select.nvim",
  -- "flash.nvim",
  -- "telescope.nvim",
  -- "astrolsp",
  -- "which-key.nvim"
  -- "lspsaga.nvim",
}

-- mix disabled with "enabled = false"
for _, plugin in ipairs(disabled) do
  table.insert(M, {
    plugin,
    enabled = false,
  })
end
return M
