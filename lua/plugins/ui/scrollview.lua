---@type LazySpec
return {
  "dstein64/nvim-scrollview",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    excluded_filetypes = { "nerdtree" },
    current_only = true,
    -- base = "buffer",
    -- column = 80,
    signs_on_startup = { "all" },
    diagnostics_severities = { vim.diagnostic.severity.ERROR },
  },
}
