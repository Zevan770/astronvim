---@type LazySpec
return {
  { import = "astrocommunity.test.neotest" },
  {
    "ALameLlama/compiler.nvim",
    branch = "feat/add-support-for-native-nvim-selector",
    cmd = { "CompilerOpen", "CompilerToggleResults" },
    keys = {
      { "<leader>;c", "<Cmd>CompilerOpen<CR>" },
    },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    dependencies = {
      {
        "stevearc/resession.nvim",
        optional = true,
        opts = {
          overseer = {
            -- customize here
          },
        },
      },
      { "AstroNvim/astroui", opts = { icons = { Overseer = "" } } },
    },
    ---@module "overseer"
    ---@type overseer.Config
    opts = {},
    keys = {
      { "<leader>;t", "<Cmd>OverseerToggle<CR>" },
      { "<leader>;;", "<Cmd>OverseerShell<CR>" },
      { "<leader>;r", "<Cmd>OverseerRun<CR>" },
      { "<leader>;a", "<Cmd>OverseerTaskAction<CR>" },
      { "<leader>;i", "<Cmd>checkhealth overseer<CR>" },
    },
  },

  {
    "stevearc/overseer.nvim",
    opts = function(_, opts)
      opts.dap = false
      require("astrocore").on_load("nvim-dap", function() require("overseer").enable_dap() end)
    end,
  },

  {
    "nvim-neotest/neotest",
    lazy = true,
    cmd = "Neotest",
    optional = true,
    dependencies = {
      "stevearc/overseer.nvim",
    },
    opts = function(_, opts)
      if not opts.consumers then opts.consumers = {} end
      opts.consumers.overseer = require "neotest.consumers.overseer"
    end,
  },

  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      commands = true,
      auto_reload = true,
      signs = { covered = { hl = "LineNr" }, uncovered = { hl = "Exception" } },
    },
    config = function(_, opts)
      local cov = require "coverage"
      cov.setup(opts)
      cov.load(true)
    end,
    keys = {
      {
        "]C",
        function() require("coverage").jump_next "uncovered" end,
        desc = "Next uncovered snippet.",
        noremap = true,
      },
      {
        "[C",
        function() require("coverage").jump_prev "uncovered" end,
        desc = "Previous uncovered snippet.",
        noremap = true,
      },
    },
    cmd = { "Coverage" },
  },
}
