local M = {}

function M.toggle_search_flag(flag, flag_pattern, flag_replacement)
  return function()
    local t = vim.fn.getcmdtype()
    if vim.api.nvim_get_mode().mode:sub(1, 1) ~= "c" or (t ~= "/" and t ~= "?") then return end

    local pattern = vim.fn.getcmdline()
    if not pattern then return end

    -- 检查是否存在标志
    if pattern:find(flag_pattern) then
      -- 移除标志
      pattern = pattern:gsub(vim.pesc(flag_pattern), "")
    else
      -- 添加标志到开头
      pattern = flag_replacement .. pattern
    end

    vim.fn.setcmdline(pattern, #pattern + 1)
    -- vscode 兼容性处理
    if vim.g.vscode then vim.api.nvim_input " <BS>" end
  end
end

-- 预定义一些常用标志的切换函数
M.toggle_very_magic = M.toggle_search_flag("v", "\\v", "\\v")
M.toggle_very_nomagic = M.toggle_search_flag("V", "\\V", "\\V")
M.toggle_case_sensitive = M.toggle_search_flag("C", "\\C", "\\C")
M.toggle_ignore_case = M.toggle_search_flag("c", "\\c", "\\c")

M.toggle_word_boundary = function()
  return function()
    local t = vim.fn.getcmdtype()
    if vim.api.nvim_get_mode().mode:sub(1, 1) ~= "c" or (t ~= "/" and t ~= "?") then return end

    local pattern = vim.fn.getcmdline()
    if not pattern then return end

    -- 检查模式中是否使用了 very magic 模式
    local has_very_magic = pattern:find "\\v" ~= nil

    -- 根据正则模式选择正确的边界标记
    -- 在 very magic 模式下，单词边界是 < 和 >
    -- 在普通模式下，单词边界是 \< 和 \>
    local start_boundary = has_very_magic and "<" or "\\<"
    local end_boundary = has_very_magic and ">" or "\\>"

    -- 检查是否已有单词边界
    local has_start = pattern:match("^" .. vim.pesc(start_boundary))
    local has_end = pattern:match(vim.pesc(end_boundary) .. "$")

    if has_start and has_end then
      -- 移除单词边界
      pattern = pattern:gsub("^" .. vim.pesc(start_boundary), "")
      pattern = pattern:gsub(vim.pesc(end_boundary) .. "$", "")
    else
      -- 添加单词边界
      pattern = start_boundary .. pattern .. end_boundary
    end

    vim.fn.setcmdline(pattern, #pattern + 1)
    if vim.g.vscode then vim.api.nvim_input " <BS>" end
  end
end

return M
