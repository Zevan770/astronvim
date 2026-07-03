---@type LazySpec
return {
  {
    "johmsalas/text-case.nvim",
    enabled = false,
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
    event = "User AstroFile",
    dependencies = {
      "gregorias/coop.nvim",
      {
        "folke/which-key.nvim",
        opts = function()
          local wke = require("coerce.keymaps").which_key_expand
          require("which-key").add {
            { "yo<Space>", group = "+Coerce word", expand = wke.normal_mode, mode = "n" },
            { "yo", group = "+Coerce motion", expand = wke.motion_mode, mode = "n" },
            { "O", group = "+Coerce visual", expand = wke.visual_mode, mode = "x" },
          }
        end,
      },
    },
    config = function() require("coerce").setup {} end,
  },
}
