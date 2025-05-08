local M = {}
M.format_git_hunks = function(bufnr)
  bufnr = bufnr or 0
  local ignore_filetypes = { "lua", "python" }
  local format = require("conform").format
  if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
    format { lsp_fallback = true, timeout_ms = 500 }
    return
  end

  local hunks = require("gitsigns").get_hunks(bufnr)
  if hunks == nil then return end

  local function format_range()
    if next(hunks) == nil then
      vim.notify("done formatting git hunks", "info", { title = "formatting" })
      return
    end
    local hunk = nil
    while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
      hunk = table.remove(hunks)
    end

    if hunk ~= nil and hunk.type ~= "delete" then
      local start = hunk.added.start
      local last = start + hunk.added.count
      -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
      local last_hunk_line = vim.api.nvim_buf_get_lines(bufnr, last - 2, last - 1, true)[1]
      local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
      format({ range = range, lsp_fallback = true, timeout_ms = 1000 }, function()
        vim.defer_fn(function() format_range() end, 1)
      end)
    end
  end

  format_range()
end

---@param bufnr integer
---@param ... string
---@return string
M.conform_first_avail = function(bufnr, ...)
  local conform = require "conform"
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then return formatter end
  end
  return select(1, ...)
end

return M
