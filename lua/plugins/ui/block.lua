return {
  {
    "HampusHauffman/block.nvim",
    config = function()
      require("block").setup({
        automatic = true,
      })
    end
  },
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = false
      }
    }
  }
}
