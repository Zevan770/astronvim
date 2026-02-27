---@type LazySpec
return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal. Otherwise optional.
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
      {
        "e-cal/opencode-tmux.nvim",
        opts = {
          cmd = "opencode --port",
          options = "-h",
          focus = true,
          auto_close = false,
          allow_passthrough = false,
          find_sibling = true,
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      -- vim.g.opencode_opts = require("astrocore").extend_tbl(vim.g.opencode_opts, {
      --   auto_reload = true,
      --   server = {
      --     -- port = 4007,
      --   },
      --   -- Your configuration, if any — see `lua/opencode/config.lua`
      -- })

      -- Recommended keymaps
      vim.keymap.set("n", "<leader>oot", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
      vim.keymap.set("n", "<leader>ooA", function() require("opencode").ask() end, { desc = "Ask opencode" })
      vim.keymap.set(
        "n",
        "<leader>ooa",
        function() require("opencode").ask "@cursor: " end,
        { desc = "Ask opencode about this" }
      )
      vim.keymap.set(
        "v",
        "<leader>ooa",
        function() require("opencode").ask "@selection: " end,
        { desc = "Ask opencode about selection" }
      )
      vim.keymap.set(
        "n",
        "<leader>oon",
        function() require("opencode").command "session_new" end,
        { desc = "New opencode session" }
      )
      vim.keymap.set(
        "n",
        "<leader>ooy",
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
        "<leader>oos",
        function() require("opencode").select() end,
        { desc = "Select opencode prompt" }
      )

      -- Example: keymap for custom prompt
      vim.keymap.set(
        "n",
        "<leader>ooe",
        function() require("opencode").prompt "Explain @cursor and its context" end,
        { desc = "Explain this code" }
      )
    end,
  },

  {
    "sudo-tee/opencode.nvim",
    enabled = false,
    name = "opencode-nvim-ui",
    ---@module "opencode"
    ---@type opencode.Opts
    opts = {},
    config = function(_, opts) require("opencode").setup(opts) end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
