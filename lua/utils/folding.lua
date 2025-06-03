local M = {}
--------------------------------------------------------------------------------

local function normal(cmdStr) vim.cmd.normal { cmdStr, bang = true } end
local function normal_no_bang(cmdStr) vim.cmd.normal { cmdStr, bang = false } end

-- `h` closes folds when at the beginning of a line.
function M.h()
  local count = vim.v.count1 -- saved as `normal` affects it
  for _ = 1, count, 1 do
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local textBeforeCursor = vim.api.nvim_get_current_line():sub(1, col)
    local onIndentOrFirstNonBlank = textBeforeCursor:match "^%s*$"
    if onIndentOrFirstNonBlank then
      local wasFolded = my_utils.is_vscode and pcall(normal_no_bang, "zc") or pcall(normal, "zc")
      if not wasFolded then normal "h" end
    else
      normal "h"
    end
  end
end

-- `l` on a folded line opens the fold.
function M.l()
  local count = vim.v.count1 -- count needs to be saved due to `normal` affecting it
  for _ = 1, count, 1 do
    local isOnFold = vim.fn.foldclosed "." > -1 ---@diagnostic disable-line: param-type-mismatch
    local action = isOnFold and "zo" or "l"
    pcall(normal, action)
  end
end

--------------------------------------------------------------------------------
return M
