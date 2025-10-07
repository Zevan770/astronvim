---@type LazySpec
return {
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
    -- enabled = false,
    dependencies = { "scottmckendry/pick-resession.nvim" },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          my_utils.key.replace_group("n", maps, "<Leader>S", "<Leader>q")
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
        end,
      },
    },
  },
}
