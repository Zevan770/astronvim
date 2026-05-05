---@type LazySpec
-- https://sitr.us/2026/05/03/embedded-sql-highlighting-in-neovim/#:~:text=The%20way%20I%20did%20that%20was%20to%20set%20that%20highlight%20to%20be%20transparent
-- 让 lsp 的 string 透明，从而优先使用 treesitter 的 hl_group
vim.api.nvim_set_hl(0, "@lsp.type.string", {})
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
      Eye = "",
    },
    lazygit = false,
    folding = {
      enabled = true,
    },
  },
}
