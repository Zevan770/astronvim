---@type LazySpec
return {
  {
    "chrisgrieser/nvim-origami",
    enabled = false,
    event = "User AstroFile",
    dependencies = {
      "kevinhwang91/nvim-ufo",
    },
    opts = {
      -- requires with `nvim-ufo`
      keepFoldsAcrossSessions = package.loaded["ufo"] ~= nil,

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

  {
    "OXY2DEV/foldtext.nvim",
    enabled = false,
    lazy = false,
    opts = {
      {
        -- Ignore buffers with these buftypes.
        ignore_buftypes = {},
        -- Ignore buffers with these filetypes.
        ignore_filetypes = {},
        -- Ignore buffers/windows if the result
        -- is false.
        condition = function() return true end,

        styles = {
          default = {
            { kind = "bufline" },
          },

          -- Custom foldtext.
          custom_a = {
            -- Only on these filetypes.
            filetypes = {},
            -- Only on these buftypes.
            buftypes = {},

            -- Only if this condition is
            -- true.
            condition = function(win) return vim.wo[win].foldmethod == "manual" end,

            -- Parts to create the foldtext.
            parts = {
              { kind = "fold_size" },
            },
          },
        },
      },
    },
  },
}
