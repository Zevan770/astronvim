---@type LazySpec
return {
  {
    "nvim-mini/mini.sessions",
    version = false,
    lazy = false,
    keys = {
      {
        "<leader>qs",
        function()
          local session_name = vim.v.this_session
          if session_name == "" then
            vim.ui.input({ prompt = "Session name" }, function(input)
              session_name = input
              if session_name ~= "" then
                require("mini.sessions").write(session_name)
              else
                vim.notify("Session name cannot be empty", vim.log.levels.ERROR)
              end
            end)
          end
        end,
        desc = "Save Session",
      },
      { "<leader>ql", function() require("mini.sessions").read() end, desc = "Read Session" },
      { "<leader>qf", function() require("mini.sessions").select() end, desc = "Find Session" },
      { "<leader>qd", function() vim.g.minisessions_disable = true end, desc = "Disable Session" },
      { "<leader>qr", function() require("mini.sessions").restart() end, desc = "Restart" },
    },
    opts = {
      -- Whether to read default session if Neovim opened without file arguments
      autoread = false,

      -- Whether to write currently read session before leaving it
      autowrite = true,

      -- Directory where global sessions are stored (use `''` to disable)
      -- directory = --<"session" subdir of user data directory from |stdpath()|>,

      -- File for local session (use `''` to disable)
      file = "Session.vim",

      -- Whether to force possibly harmful actions (meaning depends on function)
      force = { read = false, write = true, delete = false },

      -- Hook functions for actions. Default `nil` means 'do nothing'.
      hooks = {
        -- Before successful action
        pre = { read = nil, write = nil, delete = nil },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
      },

      -- Whether to print session path after action
      verbose = { read = false, write = true, delete = true },
    },
  },
  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>q.", function() require("persistence").load() end,                         desc = "Restore Session" },
      { "<leader>qf", function() require("persistence").select() end,                       desc = "Find Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end,          desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                         desc = "Don't Save Current Session" },
      { "<leader>qs", function() require("persistence").save() end,                         desc = "Save Current Session" },
      { "<leader>qr", [[<Cmd>restart lua require("persistence").load({ last = true })<cr>]] }
    },
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>S"] = vim.tbl_get(opts, "_map_sections", "S")
      my_utils.key.replace_group("n", maps, "<Leader>S", "<Leader>q")
    end,
  },
  {
    "stevearc/resession.nvim",
    enabled = false,
    dependencies = { "scottmckendry/pick-resession.nvim" },
    specs = {
      {
        "AstroNvim/astrocore",
        optinal = true,
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>qs"] = function()
            vim.ui.input({ prompt = "Session name" }, function(selected)
              if selected then
                require("resession").save(selected)
              else
                require("resession").save()
              end
            end)
          end
          maps.n["<Leader>qf"] = function() require("pick-resession").pick { dir = "dirsession" } end
          maps.n["<Leader>qF"] = function() require("pick-resession").pick {} end
          maps.n["<Leader>qr"] = { [[<Cmd>restart lua require("resession").load "Last Session"<cr>]] }
        end,
      },
    },
  },
}
