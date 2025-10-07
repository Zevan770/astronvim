---@type LazySpec
return {
  {
    "folke/sidekick.nvim",
    ---@module "sidekick"
    ---@type sidekick.Config
    opts = {
      cli = {
        win = {
          keys = {
            win_p = false,
          },
        },
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if require("sidekick").nes_jump_or_apply() then
            return -- jumped or applied
          end

          -- if you are using Neovim's native inline completions
          if vim.lsp.inline_completion.get() then return end

          -- any other things (like snippets) you want to do on <tab> go here.

          -- fall back to normal tab
          return "<tab>"
        end,
        mode = { "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>oaa",
        function() require("sidekick.cli").toggle { focus = true } end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>oac",
        function()
          -- Same as above, but opens Claude directly
          require("sidekick.cli").toggle { name = "claude", focus = true }
        end,
        desc = "Sidekick Claude Toggle",
      },
      {
        "<leader>oaq",
        function()
          -- Same as above, but opens Claude directly
          require("sidekick.cli").toggle { name = "qwen", focus = true }
        end,
        desc = "Sidekick Qwen Toggle",
      },
      {
        "<leader>oas",
        function() require("sidekick.cli").send { selection = true } end,
        mode = { "v" },
        desc = "Sidekick Send Visual Selection",
      },
      {
        "<A-c>",
        function() require("sidekick.cli").focus() end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      {
        "<leader>oap",
        function() require("sidekick.cli").prompt() end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
}
