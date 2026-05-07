return {
  {
    "diogo464/hotreload.nvim",
    enabled = vim.fn.has "linux" == 1,
    opts = {}, -- Uses fs_event watchers by default
  },
}
