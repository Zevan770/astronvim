---@type LazySpec
return {
  -- {
  --   "NickvanDyke/opencode.nvim",
  --   dependencies = {
  --     -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal. Otherwise optional.
  --     { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  --   },
  --   ---@module "opencode"
  --   ---@type opencode.Opts
  --   opts = {
  --     -- Your configuration, if any
  --   },
  --   keys = {
  --     -- Recommended keymaps
  --     { "<leader>ooA", function() require("opencode").ask() end, desc = "Ask opencode" },
  --     {
  --       "<leader>ooa",
  --       function() require("opencode").ask "@cursor: " end,
  --       desc = "Ask opencode about this",
  --       mode = "n",
  --     },
  --     {
  --       "<leader>ooa",
  --       function() require("opencode").ask "@selection: " end,
  --       desc = "Ask opencode about selection",
  --       mode = "v",
  --     },
  --     { "<leader>oot", function() require("opencode").toggle() end, desc = "Toggle embedded opencode" },
  --     { "<leader>oon", function() require("opencode").command "session_new" end, desc = "New session" },
  --     { "<leader>ooy", function() require("opencode").command "messages_copy" end, desc = "Copy last message" },
  --     {
  --       "<S-C-u>",
  --       function() require("opencode").command "messages_half_page_up" end,
  --       desc = "Scroll messages up",
  --     },
  --     {
  --       "<S-C-d>",
  --       function() require("opencode").command "messages_half_page_down" end,
  --       desc = "Scroll messages down",
  --     },
  --     {
  --       "<leader>oop",
  --       function() require("opencode").select_prompt() end,
  --       desc = "Select prompt",
  --       mode = { "n", "v" },
  --     },
  --     -- Example: keymap for custom prompt
  --     {
  --       "<leader>ooe",
  --       function() require("opencode").prompt "Explain @cursor and its context" end,
  --       desc = "Explain code near cursor",
  --     },
  --   },
  -- },

  {
    "sudo-tee/opencode.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "opencode_output" },
        },
      },
    },
  },
}
