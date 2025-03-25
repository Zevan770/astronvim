vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline = "neovim",
      --content  = "text",
      --priority = 0,
      -- selector = "textarea",
      takeover = "never",
    },
  },
}
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

local disabled = {
  "folke/noice.nvim",
  "rebelot/heirline.nvim",
  "wallpants/ghost-text.nvim",
  "codeium.nvim",
}

local specs = {}
-- mix disabled with "enabled = false"
for _, plugin in ipairs(disabled) do
  table.insert(specs, {
    plugin,
    optional = true,
    enabled = false,
  })
end
---@type LazySpec

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.showtabline = 0
    vim.opt.laststatus = 0
  end,
})

---@type LazySpec
return {
  {
    "glacambre/firenvim",

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    module = false,
    build = function() vim.fn["firenvim#install"](0) end,
    specs = specs,
  },
}
