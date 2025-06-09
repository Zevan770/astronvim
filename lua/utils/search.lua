local M = {}

function M.toggle_search_pattern(flag)
  return function()
    local t = vim.fn.getcmdtype()
    if vim.api.nvim_get_mode().mode:sub(1, 1) ~= "c" and t ~= "/" and t ~= "?" then return end

    local pattern = vim.fn.getcmdline()
    if not pattern or pattern:sub(1, 1) == t then return end

    local flag_w1, flag_w2, flag_c, flag_r
    local flag_end
    local i = 1
    while i <= #pattern do
      local c = pattern:sub(i, i)
      if flag_end then
        if c == "\\" then
          i = i + 1
          if i > #pattern then break end
          local c2 = pattern:sub(i, i)
          if c2 == ">" and not flag_r and i == #pattern then flag_w2 = true end
        else
          if c == ">" and flag_r and i == #pattern then flag_w2 = true end
        end
        goto continue
      end

      if c == "\\" then
        i = i + 1
        if i > #pattern then break end
        local c2 = pattern:sub(i, i)
        if c2 == "<" and not flag_r then
          flag_w1 = true
        elseif c2 == "C" then
          flag_c = true
        elseif c2 == "v" then
          flag_r = true
        else
          flag_end = i - 1
          i = i - 2
        end
      else
        if c == "<" and flag_r then
          flag_w1 = true
        else
          flag_end = i
          i = i - 1
        end
      end

      ::continue::
      i = i + 1
    end

    local w2_len
    if flag_w2 then
      w2_len = flag_r and 1 or 2
    else
      w2_len = 0
    end

    pattern = flag_end and pattern:sub(flag_end, #pattern - w2_len) or ""
    if flag == "w" and (not flag_w1 or not flag_w2) or flag ~= "w" and flag_w1 and flag_w2 then
      w2_len = flag_r and 1 or 2
      pattern = (flag_r and "<" or "\\<") .. pattern .. (flag_r and ">" or "\\>")
    else
      w2_len = 0
    end
    if flag == "c" and not flag_c or flag ~= "c" and flag_c then pattern = "\\C" .. pattern end
    if flag == "r" and not flag_r or flag ~= "r" and flag_r then pattern = "\\v" .. pattern end

    vim.fn.setcmdline(pattern, #pattern + 1 - w2_len)
    -- vscode does not trigger flash after setcmdline
    if vim.g.vscode then vim.api.nvim_input " <BS>" end
  end
end

return M
