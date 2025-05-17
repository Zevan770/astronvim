---@type LazySpec
return {
  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qc", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qf", function() require("persistence").select() end,desc = "Find Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
      { "<leader>qs", function() require("persistence").save() end, desc = "Save Current Session" },
    },

    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>q"] = maps.n["<Leader>S"]
          maps.n["<Leader>S"] = false
        end,
      },
    },
  },

  {
    "stevearc/resession.nvim",
    enabled = false,
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>p"] = maps.n["<Leader>S"]
          maps.n["<Leader>S"] = false
          maps.n["<Leader>pl"] = {
            function() require("resession").load "Last Session" end,
            desc = "Load last session",
          }
          maps.n["<Leader>ps"] = {
            function() require("resession").save() end,
            desc = "Save this session",
          }
          maps.n["<Leader>pS"] = {
            function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
            desc = "Save this dirsession",
          }
          maps.n["<Leader>pt"] = {
            function() require("resession").save_tab() end,
            desc = "Save this tab's session",
          }
          maps.n["<Leader>pd"] = {
            function() require("resession").delete() end,
            desc = "Delete a session",
          }
          maps.n["<Leader>pD"] = {
            function() require("resession").delete(nil, { dir = "dirsession" }) end,
            desc = "Delete a dirsession",
          }
          maps.n["<Leader>po"] = { function() require("resession").load() end, desc = "Load a session" }
          maps.n["<Leader>pp"] = {
            function() require("resession").load(nil, { dir = "dirsession" }) end,
            desc = "Load a dirsession",
          }
          maps.n["<Leader>pc"] = {
            function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
            desc = "Load current dirsession",
          }
        end,
      },
    },
  },
}
