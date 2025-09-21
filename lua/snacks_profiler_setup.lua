_G.dd = function(...) require("snacks.debug").inspect(...) end
_G.bt = function(...) require("snacks.debug").backtrace() end
_G.p = function(...) require("snacks.debug").profile(...) end
vim._print = function(_, ...) dd(...) end

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
