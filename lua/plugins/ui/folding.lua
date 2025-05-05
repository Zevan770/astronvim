---@type LazySpec
return {
  {
    "chrisgrieser/nvim-origami",
    event = "User AstroFile",
    opts = {
      -- requires with `nvim-ufo`
      keepFoldsAcrossSessions = require("astrocore").is_available "nvim-ufo",

      pauseFoldsOnSearch = false,

      -- incompatible with `nvim-ufo`
      foldtextWithLineCount = {
        enabled = false,
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
