---@type LazySpec
-- Lazy.nvim
return {
  "xvzc/chezmoi.nvim",
  dependencies = { "nvim-lua/plenary.nvim", { "telescope.nvim", optional = true }
 },
  config = function()
    require("chezmoi").setup {
      -- your configurations
    }
  end,
}
