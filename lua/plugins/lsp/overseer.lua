---@type LazySpec
return {
  { import = "astrocommunity.test.neotest" },
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
    opts = function(self, opts)
      vim.api.nvim_create_user_command("Make", function(params)
        -- Insert args at the '$*' in the makeprg
        local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
        if num_subs == 0 then cmd = cmd .. " " .. params.args end
        local task = require("overseer").new_task {
          cmd = vim.fn.expandcmd(cmd),
          components = {
            {
              "on_output_quickfix",
              open = not params.bang,
              open_height = 8,
              errorformat = vim.o.errorformat,
            },
            "default",
          },
        }
        task:start()
      end, {
        desc = "Run your makeprg as an Overseer task",
        nargs = "*",
        bang = true,
      })

      ---@module "overseer"
      ---@type overseer.Config
      return {}
    end,
    keys = {
      { "<leader>;t", "<Cmd>OverseerToggle<CR>" },
      { "<leader>;;", ":OverseerShell " },
      { "<leader>;f", "<Cmd>OverseerRun<CR>" },
      { "<leader>;a", "<Cmd>OverseerTaskAction<CR>" },
      { "<leader>;m", "<Cmd>Make<CR>" },
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
