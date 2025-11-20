if true then return {} end
---@type LazySpec
return {
  {
    "HampusHauffman/block.nvim",
    -- branch = "re",
    config = function()
      require("block").setup {
        -- automatic = true,
      }
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = false,
      },
    },
  },
}
