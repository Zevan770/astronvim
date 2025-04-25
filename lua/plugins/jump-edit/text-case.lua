---@type LazySpec
return {
  {
    "johmsalas/text-case.nvim",
    -- event = "User AstroFile",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup {
        default_keymappings_enabled = true,
        prefix = "gm",
      }
      require("telescope").load_extension "textcase"
    end,
    keys = {
      "gm", -- Default invocation prefix
      { "gm.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
  },
}
