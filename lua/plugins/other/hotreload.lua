return {
  {
    "diogo464/hotreload.nvim",
    enabled = my_utils.is_nixos,
    opts = {}, -- Uses fs_event watchers by default
  },
}
