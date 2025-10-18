local M = {}
local disabled = {
  "image.nvim",
  "neotree.nvim",
  -- "render-markdown.nvim",
  -- "aerial.nvim",
  -- "symbol-usage.nvim",
  -- "gitsigns.nvim",
  -- "hlargs.nvim",
  -- "bionic-reading.nvim",
  -- "nvim-ufo",
  -- "vim-illuminate",
  -- "render-markdown.nvim",
  -- "markview.nvim",
  -- "mcphub.nvim",
  -- "vim-illuminate",
  -- "vim-fetch",
  -- "neogit",
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
