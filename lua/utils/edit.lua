local M = {}

---@desc if there is a tab with pwd at dir
---          then go to that tab and edit file
---      else tabnew and tcd dir and edit file
M.edit_or_tabnew = function(dir, file)
  dir = vim.fs.normalize(dir)
  M.tabnewat(dir)
  vim.cmd.edit(file)
end

M.tabnewat = function(dir)
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
