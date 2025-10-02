---@type LazySpec
return {
  -- {
  --   "AstroNvim/astrocommunity",
  --   -- { import = "astrocommunity.completion.copilot-lua" },
  --   -- { import = "astrocommunity.completion.copilot-cmp" },
  --   -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "folke/sidekick.nvim",
    ---@module "sidekick"
    ---@type sidekick.Config
    opts = {
      cli = {
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
        mode = { "i", "n" },
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
        "<leader>oas",
        function() require("sidekick.cli").send { selection = true } end,
        mode = { "v" },
        desc = "Sidekick Send Visual Selection",
      },
      {
        "<c-.>",
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
