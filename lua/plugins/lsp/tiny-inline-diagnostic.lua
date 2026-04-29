---@type LazySpec
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000, -- needs to be loaded in first
  config = function()
    vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
    require("tiny-inline-diagnostic").setup {
      transparent_bg = false,
      options = {
        multilines = { enabled = true, always_show = false },
        virt_texts = { priority = 2048 },
      },
      disabled_ft = {},
    }

    vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
  end,
}
