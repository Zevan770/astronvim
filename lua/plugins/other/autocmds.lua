local function augroup(name, fn) fn(vim.api.nvim_create_augroup(name, { clear = true })) end
local autocmd = vim.api.nvim_create_autocmd

-- Display help|man in vertical splits and map 'q' to quit
augroup("my.help", function(g)
  local function open_vert()
    -- do nothing for floating windows or if this is
    -- the fzf-lua minimized help window (height=1)
    local cfg = vim.api.nvim_win_get_config(0)
    if cfg and (cfg.external or cfg.relative and #cfg.relative > 0) or vim.api.nvim_win_get_height(0) == 1 then
      return
    end
    -- do not run if Diffview is open
    if vim.g.diffview_nvim_loaded and require("diffview.lib").get_current_view() then return end
    vim.cmd "wincmd L"
    vim.cmd "vertical"
    vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = true })
  end

  autocmd("FileType", {
    group = g,
    pattern = "help,man",
    callback = open_vert,
  })
  -- we also need this auto command or help
  -- still opens in a split on subsequent opens
  autocmd("BufEnter", {
    group = g,
    pattern = "*.txt",
    callback = function()
      if vim.bo.buftype == "help" then open_vert() end
    end,
  })
  autocmd("BufHidden", {
    group = g,
    pattern = "man://*",
    callback = function()
      if vim.bo.filetype == "man" then
        local bufnr = vim.api.nvim_get_current_buf()
        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(bufnr) then vim.api.nvim_buf_delete(bufnr, { force = true }) end
        end, 0)
      end
    end,
  })
end)

return {}
