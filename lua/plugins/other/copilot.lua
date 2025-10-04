---@type LazySpec
return {
  -- {
  --   "AstroNvim/astrocommunity",
  --   -- { import = "astrocommunity.completion.copilot-lua" },
  --   -- { import = "astrocommunity.completion.copilot-cmp" },
  --   -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
