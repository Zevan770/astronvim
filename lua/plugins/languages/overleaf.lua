if true then return {} end
return {
  {
    "richwomanbtc/overleaf.nvim",
    config = function()
      require("overleaf").setup {
        sync_dir = "~/.overleaf",
        keys = false,
      }
    end,
    build = "cd node && pnpm install",
  },
}
