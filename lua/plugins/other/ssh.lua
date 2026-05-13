if true then return {} end
---@type LazySpec
return {
  -- Using lazy.nvim (with snacks.nvim)
  {
    "nosduco/remote-sshfs.nvim",
    dependencies = { "folke/snacks.nvim", "nvim-lua/plenary.nvim" },
    opts = { ui = { picker = "snacks" } },
  },
}
