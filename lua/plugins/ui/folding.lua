---@type LazySpec
return {
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
      -- requires with `nvim-ufo`
      keepFoldsAcrossSessions = package.loaded["ufo"] ~= nil,

      pauseFoldsOnSearch = true,

      -- incompatible with `nvim-ufo`
      foldtextWithLineCount = {
        enabled = package.loaded["ufo"] == nil,
        template = "   %s lines", -- `%s` gets the number of folded lines
        hlgroupForCount = "Comment",
      },

      foldKeymaps = {
        setup = true, -- modifies `h` and `l`
        hOnlyOpensOnFirstColumn = false,
      },

      -- redundant with `nvim-ufo`
      autoFold = {
        enabled = false,
        kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
      },
    }, -- needed even when using default config
  },
}
