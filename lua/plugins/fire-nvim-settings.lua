if not vim.g.started_by_firenvim then return {} end

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
return { -- disable these plugin when started by firenvim
  -- { "folke/noice.nvim", optional = true, enabled = false },
  -- {
  --   "rebelot/heirline.nvim",
  --   optional = true,
  --   enabled = false,
  -- },
}
