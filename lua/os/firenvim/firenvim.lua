local disabled = {}
vim.tbl_map(function(plugin) disabled[plugin] = true end, {
  "noice.nvim",
  "neoscroll.nvim",
  "heirline.nvim",
  "ghost-text.nvim",
  "codeium.nvim",
  "smear-cursor.nvim",
  "incline.nvim",
})

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return not disabled[plugin.name] end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.showtabline = 0
    vim.opt.laststatus = 0
  end,
})
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

-- Autocmd: detect hostname-like fragments in buffer name and set filetype accordingly
local aug = vim.api.nvim_create_augroup("HostnameDetectFiletype", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufEnter" }, {
  group = aug,
  -- Use a callback so we can access the buffer that triggered the event
  callback = function(ev)
    local bufnr = ev.buf or 0
    -- full path or name
    local full_name = vim.api.nvim_buf_get_name(bufnr)
    -- try to use tail (filename) first; fallback to full name if tail is empty
    local tail = vim.fn.fnamemodify(full_name, ":t")
    local bufname = tail ~= "" and tail or full_name
    local name = vim.fn.tolower(bufname)

    -- decide filetype based on hostname-like fragments
    local ft = nil
    if name:find("github.com", 1, true) then
      ft = "markdown"
    elseif name:find("cocalc.com", 1, true) or name:find("kaggleusercontent.com", 1, true) then
      ft = "python"
    elseif name:find("localhost", 1, true) then
      ft = "python"
    elseif name:find("reddit.com", 1, true) then
      ft = "markdown"
    elseif name:find("stackexchange.com", 1, true) or name:find("stackoverflow.com", 1, true) then
      ft = "markdown"
    elseif name:find("slack.com", 1, true) or name:find("gitter.com", 1, true) then
      ft = "markdown"
    end

    if ft then
      -- set the buffer-local filetype for the buffer that triggered the autocmd
      vim.bo[bufnr].filetype = ft
    end
  end,
})

return {}
