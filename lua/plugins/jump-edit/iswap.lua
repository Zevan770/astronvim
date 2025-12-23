return {
  {
    "mizlan/iswap.nvim",
    event = "User AstroFile",
    enabled = false, -- TODO:disable util it supports nvim-treesitter main branch
    opts = {
      -- The keys that will be used as a selection, in order
      -- ('asdfghjklqwertyuiopzxcvbnm' by default)
      -- keys = "qwertyuiop",
      -- Move cursor to the other element in ISwap*With commands
      -- default false
      move_cursor = true,

      -- Automatically swap with only two arguments
      -- default nil
      autoswap = true,

      -- Other default options you probably should not change:
      debug = nil,
    },
    keys = {
      { "gsi", "<Cmd>IMove<CR>" },
    },
  },
}
