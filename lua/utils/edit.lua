local M = {}

---@desc if there is a tab with pwd at dir
---          then go to that tab and edit file
---      else tabnew and tcd dir and edit file
M.edit_or_tabnew = function(dir, file)
  M.tabnewat(dir)
  vim.cmd.edit(file)
end

M.tabnewat = function(dir)
  local tabpages = vim.api.nvim_list_tabpages()
  for _, tabpage in ipairs(tabpages) do
    local win = vim.api.nvim_tabpage_get_win(tabpage)
    local cwd = vim.api.nvim_win_call(win, function() return vim.fn.getcwd() end)
    if cwd == dir then
      vim.api.nvim_set_current_tabpage(tabpage)
      return
    end
  end
  vim.cmd.tabnew()
  vim.cmd.tcd(dir)
end

return M
