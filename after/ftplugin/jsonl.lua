vim.keymap.set(
  "n",
  "<localleader><space>",
  function() vim.cmd.terminal("fx -s " .. vim.api.nvim_buf_get_name(0) .. " | fx") end,
  { buffer = true }
)

vim.keymap.set("n", "<localleader>x", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line_num = row -- 行号从1开始
  local file_path = vim.api.nvim_buf_get_name(0)

  if file_path == "" then
    -- 未保存的缓冲区，用临时文件方案
    local lines = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)
    local line_content = lines[1] or ""
    vim.fn.jobstart({ "sh", "-c", "echo " .. vim.fn.shellescape(line_content) .. " | fx" }, {})
  else
    -- 使用 sed 读取特定行，完全避免通过 shell 传递大字符串
    require("astrocore").toggle_term_cmd("sed -n " .. line_num .. "p " .. vim.fn.shellescape(file_path) .. " | fx")
  end
end, {
  desc = "Send current line to fx (using sed)",
  buffer = true,
})

vim.treesitter.language.register("json", "jsonl")
