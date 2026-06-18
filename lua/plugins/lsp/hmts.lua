if not my_utils.is_nixos then return {} end
return {
  {
    -- "calops/hmts.nvim", -- broken on neovim 0.12
    "charliie-dev/hmts.nvim", -- use this fork
    branch = "combined-fixes",
  },
}
