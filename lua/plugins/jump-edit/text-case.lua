---@type LazySpec
return {
  {
    "johmsalas/text-case.nvim",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup {
        default_keymappings_enabled = true,
        prefix = "co",
      }
      require("telescope").load_extension "textcase"
    end,
    keys = {
      "co", -- Default invocation prefix
      { "cof", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
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

  {
    "gregorias/coerce.nvim",
    dependencies = {
      "gregorias/coop.nvim",
    },
    tag = "v4.1.0",
    opts = {
      default_mode_keymap_prefixes = {
        normal_mode = "cx",
        motion_mode = "cxx",
        visual_mode = "X",
      },
      -- Set any field to false to disable that mode.
      default_mode_mask = {
        normal_mode = true,
        motion_mode = true,
        visual_mode = true,
      },
    },
    keys = {
      { "cx" },
    },
  },
}
