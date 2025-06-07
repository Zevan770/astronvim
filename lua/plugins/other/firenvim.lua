-- if not vim.g.started_by_firenvim then return {} end

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   command = "set filetype=markdown",
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*kimi*", -- 这里的模式应匹配kimi相关的网址
--   command = "quit", -- 匹配时执行退出命令
-- })

---@type LazySpec
return {
  {
    "glacambre/firenvim",

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = false,
    cond = not not vim.g.started_by_firenvim or not not vim.env.bootstrap_firenvim,
    -- module = false,
    build = function()
      require("lazy").load { plugins = "firenvim", wait = true }
      vim.fn["firenvim#install"](0)
    end,
    -- module = false,
    -- config = function() end,
  },
}
