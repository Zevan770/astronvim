return {
  {
    "stasfilin/nvim-sandman", -- blocking network access from plugins
    config = function()
      require("nvim_sandman").setup {
        enabled = true,
        mode = "block_all", -- block_all | blocklist | allowlist
        allow = { "lazy.nvim", "blink.cmp", "nvim-treesitter", "mason.nvim" },
      }
    end,
  },
}
