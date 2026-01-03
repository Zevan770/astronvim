-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    local code_actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    local hover = null_ls.builtins.hover
    local completion = null_ls.builtins.completion

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- diagnostics.selene,

      -- Common Code Actions
      -- code_actions.gitsigns,
      -- common refactoring actions based off the Refactoring book by Martin Fowler
      -- code_actions.refactoring,
      -- code_actions.proselint, -- English prose linter

      -- nix
      diagnostics.statix, -- Lints and suggestions for Nix.
      code_actions.statix, -- Lints and suggestions for Nix.
      diagnostics.deadnix, -- Scan Nix files for dead code.
    })
  end,
}
