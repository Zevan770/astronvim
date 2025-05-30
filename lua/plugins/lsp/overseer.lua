---@type LazySpec
return {
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.test.neotest" },
  -- { import = "astrocommunity.code-runner.compiler-nvim" },
  -- {
  --   "Zeioth/compiler.nvim",
  --   opts = {},
  -- },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          my_utils.replace_group("n", maps, "<leader>M", "<Leader>;")
        end,
      },
      {
        "stevearc/resession.nvim",
        optional = true,
        opts = {
          overseer = {
            -- customize here
          },
        },
      },
    },
    ---@module "overseer"
    ---@type overseer.Config
    opts = {
      strategy = {
        "toggleterm",
        -- load your default shell before starting the task
        use_shell = true,
        -- overwrite the default toggleterm "direction" parameter
        direction = nil,
        -- overwrite the default toggleterm "highlights" parameter
        highlights = nil,
        -- overwrite the default toggleterm "auto_scroll" parameter
        auto_scroll = nil,
        -- have the toggleterm window close and delete the terminal buffer
        -- automatically after the task exits
        close_on_exit = false,
        -- have the toggleterm window close without deleting the terminal buffer
        -- automatically after the task exits
        -- can be "never, "success", or "always". "success" will close the window
        -- only if the exit code is 0.
        quit_on_exit = "never",
        -- open the toggleterm window when a task starts
        open_on_start = true,
        -- mirrors the toggleterm "hidden" parameter, and keeps the task from
        -- being rendered in the toggleable window
        hidden = false,
        -- command to run when the terminal is created. Combine with `use_shell`
        -- to run a terminal command before starting the task
        on_create = nil,
      },
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
}
