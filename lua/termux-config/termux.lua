if vim.fn.has('android') ~= 1 then return {} end
return {
  {
    "karb94/neoscroll.nvim",
    enabled = false
  }
}
