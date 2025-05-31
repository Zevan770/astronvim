---@type LazySpec
return {
  "stevearc/aerial.nvim",
  version = false,
  opts = function(_, opts)
    opts = require("astrocore").extend_tbl(opts, {
      -- ~/.local/share/nvim/lazy/aerial.nvim/lua/aerial/config.lua
      backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
      filter_kind = {
        "Array",
        "Boolean",
        "Class",
        "Constant",
        "Constructor",
        "Enum",
        "Event",
        "Field",
        "File",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        -- "Null",
        -- "Number",
        "Object",
        "Package",
        "Property",
        "String",
        "Struct",
        -- "TypeParameter",
        "Variable",
      },
      manage_folds = false,
      link_folds_to_tree = false,
      link_tree_to_folds = false,
      nav = {
        preview = true,
        autojump = true,
      },
      autojump = true,

      resize_to_content = false,
    })
    return opts
  end,
}
