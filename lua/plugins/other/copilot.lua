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
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
