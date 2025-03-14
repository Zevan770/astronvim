return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = { enabled = true },
      dim = { enabled = true },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          local title = "AstroNvim stuffs"
          local astro_dirs = {
            vim.fn.stdpath "data" .. "/lazy/AstroNvim",
            vim.fn.stdpath "data" .. "/lazy/astrocore",
            vim.fn.stdpath "data" .. "/lazy/astrolsp",
            vim.fn.stdpath "data" .. "/lazy/astroui",
            vim.fn.stdpath "data" .. "/lazy/astrocommunity",
            vim.fn.stdpath "config",
          }
          maps.n["<Leader>h"] = { desc = require("astroui").get_icon("Help", 1, true) .. "Help" }
          maps.v["<Leader>h"] = maps.n["<Leader>h"]
          maps.n["<Leader>hD"] = {
            function()
              Snacks.picker.grep {
                dirs = astro_dirs,
                title = title,
                glob = { "*.lua" },
              }
            end,
            desc = "grep" .. title,
          }
          maps.n["<Leader>hd"] = {
            function()
              Snacks.picker.files {
                dirs = astro_dirs,
                title = title,
              }
            end,
            desc = title,
          }
          maps.n["<Leader>sp"] = maps.n["<Leader>fw"]
          maps.n["<Leader>sP"] = maps.n["<Leader>fc"]
          maps.n["<Leader>fj"] = { function() Snacks.picker.jumps() end, desc = "Find Jumps" }
          maps.n["<Leader>fu"] = { function() Snacks.picker.undo() end, desc = "Find Undo history" }
          maps.n["<Leader>fx"] = { function() Snacks.picker.lazy() end, desc = "Find lazy eXtension specs" }
          maps.n["<Leader>fz"] = { function() Snacks.picker.zoxide() end, desc = "Find Zoxide" }
          maps.n["<Leader>fc"] = { function() Snacks.picker.commands() end, desc = "Find Commands" }
          maps.n["<Leader>f:"] =
            { function() Snacks.picker.command_history() end, desc = "Find Command history" }
          maps.n["<Leader>f/"] =
            { function() Snacks.picker.search_history() end, desc = "Find Search history" }

          maps.n["<Leader>f<space>"] = { function() Snacks.picker() end, desc = "pick ?" }
          maps.c["<C-t>"] = {
            function()
              vim.api.nvim_feedkeys(vim.keycode "<C-c>", "n", true)
              Snacks.picker.command_history {
                config = function(o) o.pattern = vim.fn.getreg ":" end,
              }
            end,
            desc = "command history",
          }

          maps.n["<Leader>."] = { function() Snacks.scratch() end, desc = "new Scratch buffer" }

          maps.n["<Leader>ap"] = { function() Snacks.profiler.scratch() end, desc = "Profiler" }
        end,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if require("astrocore").is_available "trouble.nvim" then
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = {
              trouble_open = function(...) return require("trouble.sources.snacks").actions.trouble_open.action(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end
    end,
  },
}
