vim.keymap.set(
  "n",
  "<localleader><space>",
  function() require("toggleterm").exec("fx -s " .. vim.api.nvim_buf_get_name(0) .. " | fx") end,
  { buffer = true }
)

vim.keymap.set("n", "<localleader>x", function()
  local line = vim.api.nvim_get_current_line()
  require("toggleterm").exec("echo " .. vim.fn.shellescape(line) .. " | fx")
end, {
  desc = "Send current line to fx",
  buffer = true,
})

vim.treesitter.language.register("json", "jsonl")
