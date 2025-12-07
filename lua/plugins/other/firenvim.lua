-- if not vim.g.started_by_firenvim then return {} end

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   command = "set filetype=markdown",
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*kimi*", -- 这里的模式应匹配 kimi 相关的网址
--   command = "quit", -- 匹配时执行退出命令
-- })

local H = {}

local prev_size = {
  lines = 20,
  columns = 120,
}
-- exchange current and previous size
function H.toggle_max()
  local current_size = {
    lines = vim.opt.lines:get(),
    columns = vim.opt.columns:get(),
  }

  vim.opt.lines = prev_size.lines
  vim.opt.columns = prev_size.columns
  prev_size = current_size
end
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
    keys = {
      {
        "<M-f>",
        mode = { "n", "i" },
        H.toggle_max,
        desc = "toggle max",
      },
      { "<Esc>", mode = { "n" }, function() vim.cmd "q" end, desc = "Quit Firenvim" },
      { "<M-S-j>", function() vim.opt.lines = vim.opt.lines + 3 end, desc = "Increase lines" },
      { "<M-S-k>", function() vim.opt.lines = vim.opt.lines - 3 end, desc = "Decrease lines" },
      { "<M-S-h>", function() vim.opt.columns = vim.opt.columns - 10 end, desc = "Decrease columns" },
      { "<M-S-l>", function() vim.opt.columns = vim.opt.columns + 10 end, desc = "Increase columns" },
    },
    -- module = false,
    config = function()
      vim.api.nvim_clear_autocmds { group = "FirenvimFtdetectAugroup" }
      local aug = vim.api.nvim_create_augroup("MyFirenvimFtdetectAugroup", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = "*",
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
    end,
  },
}
