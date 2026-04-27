vim.keymap.set("n", ';p', function()
  require("toggleterm").exec("fx -s " .. vim.api.nvim_buf_get_name(0) .. " | fx")
end)

vim.treesitter.language.register("json", "jsonl")
