if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath "data" .. "/lazy/snacks.nvim"
  -- local snacks = vim.fn.stdpath "config" .. "/lua/local_plugins/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup {
    startup = {
      -- event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      event = vim.env.PROF,
      -- event = "VeryLazy",
    },
  }
end
