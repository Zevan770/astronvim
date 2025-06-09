---@type LazySpec
return {
  {
    "chrisgrieser/nvim-dr-lsp",
    event = "LspAttach",
    opts = {
      highlightCursorWordReferences = {
        enable = false,
      },
    },
  },
}
