---@type LazySpec
return {
  "windwp/nvim-autopairs",
  opts = {
    enabled = function(bufnr) return true end, -- control if auto-pairs should be enabled when attaching to a buffer
  },
}
