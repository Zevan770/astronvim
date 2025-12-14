local M = {}

---@desc if there is a tab with pwd at dir
---          then go to that tab and edit file
---      else tabnew and tcd dir and edit file
M.edit_or_tabnew = function(dir, file)
  dir = vim.fs.normalize(dir)
  file = vim.fs.normalize(file)
  M.make_sure_tab(dir)
  M.edit_or_focus_buffer(file)
end

M.edit_or_focus_buffer = function(file)
  local bufnr = vim.fn.bufnr(file, true)
  if bufnr ~= -1 then
    vim.api.nvim_set_current_buf(bufnr)
  else
    vim.cmd.edit(file)
  end
end

M.make_sure_tab = function(dir)
  local tabpages = vim.api.nvim_list_tabpages()
  for _, tabpage in ipairs(tabpages) do
    local cwd = vim.fn.getcwd(-1, tabpage)
    if vim.fs.relpath(cwd, dir) then
      vim.api.nvim_set_current_tabpage(tabpage)
      return
    end
  end
  vim.cmd.tabnew()
  vim.cmd.tcd(dir)
end

return M
