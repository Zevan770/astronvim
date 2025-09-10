---@type LazySpec
return {
  {
    "NickvanDyke/opencode.nvim",
    name = "opencode-native",
    dependencies = {
      -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal. Otherwise optional.
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    config = function()
      vim.g.opencode_opts = {
        port = "4004",
        auto_reload = true,
        -- Your configuration, if any — see `lua/opencode/config.lua`
      }

      -- Recommended keymaps
      vim.keymap.set("n", "<lead>oot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
      vim.keymap.set("n", "<lead>ooA", function() require("opencode").ask() end, { desc = "Ask opencode" })
      vim.keymap.set(
        "n",
        "<lead>ooa",
        function() require("opencode").ask "@cursor: " end,
        { desc = "Ask opencode about this" }
      )
      vim.keymap.set(
        "v",
        "<lead>ooa",
        function() require("opencode").ask "@selection: " end,
        { desc = "Ask opencode about selection" }
      )
      vim.keymap.set(
        "n",
        "<lead>oon",
        function() require("opencode").command "session_new" end,
        { desc = "New opencode session" }
      )
      vim.keymap.set(
        "n",
        "<lead>ooy",
        function() require("opencode").command "messages_copy" end,
        { desc = "Copy last opencode response" }
      )
      vim.keymap.set(
        "n",
        "<S-C-u>",
        function() require("opencode").command "messages_half_page_up" end,
        { desc = "Messages half page up" }
      )
      vim.keymap.set(
        "n",
        "<S-C-d>",
        function() require("opencode").command "messages_half_page_down" end,
        { desc = "Messages half page down" }
      )
      vim.keymap.set(
        { "n", "v" },
        "<lead>oos",
        function() require("opencode").select() end,
        { desc = "Select opencode prompt" }
      )

      -- Example: keymap for custom prompt
      vim.keymap.set(
        "n",
        "<lead>ooe",
        function() require("opencode").prompt "Explain @cursor and its context" end,
        { desc = "Explain this code" }
      )
    end,
  },

  {
    "sudo-tee/opencode.nvim",
    enabled = false,
    ---@module "opencode"
    ---@type opencode.Opts
    opts = {},
    config = function(_, opts) require("opencode").setup(opts) end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
