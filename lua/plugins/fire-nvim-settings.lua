if not vim.g.started_by_firenvim then return {} end

vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline = "neovim",
      --content  = "text",
      --priority = 0,
      selector = "textarea",
      -- takeover = "never",
    },
  },
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.showtabline = 0
    vim.opt.laststatus = 0
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "github.com_*.txt",
  command = "set filetype=markdown",
})

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
