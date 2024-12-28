---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          maps.n["<leader>c"] = { desc = " Copilot Chat" }
          maps.v["<leader>c"] = maps.n["<leader>c"]
        end,
      },
    },
    specs = {
      {
        -- Edgy integration
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          opts.left = opts.left or {}
          table.insert(opts.left, {
            ft = "codecompanion",
            size = { width = 50 },
          })
        end,
      },
    },
    keys = {
      { "<leader>ci", "<cmd>CodeCompanion<CR>", desc = "Inline", mode = { "n", "v" } },
      { "<leader>co", "<cmd>CodeCompanionChat<CR>", desc = "Chat", mode = { "n", "v" } },
    },
    opts = {
      display = {
        chat = {
          show_settings = true,
        },
      },
      strategies = {
        chat = {
          adapter = "copilot",
          slash_commands = {
            ["buffer"] = {
              callback = "strategies.chat.slash_commands.buffer",
              description = "Insert open buffers",
              opts = {
                contains_code = true,
                provider = "default", -- default|telescope|mini_pick|fzf_lua
              },
            },
            ["fetch"] = {
              callback = "strategies.chat.slash_commands.fetch",
              description = "Insert URL contents",
              opts = {
                adapter = "jina",
              },
            },
            ["file"] = {
              callback = "strategies.chat.slash_commands.file",
              description = "Insert a file",
              opts = {
                contains_code = true,
                max_lines = 3000,
                provider = "telescope", -- default|telescope|mini_pick|fzf_lua
              },
            },
            ["help"] = {
              callback = "strategies.chat.slash_commands.help",
              description = "Insert content from help tags",
              opts = {
                contains_code = false,
                max_lines = 128, -- Maximum amount of lines to of the help file to send (NOTE: each vimdoc line is typically 10 tokens)
                provider = "telescope", -- telescope|mini_pick|fzf_lua
              },
            },
            ["now"] = {
              callback = "strategies.chat.slash_commands.now",
              description = "Insert the current date and time",
              opts = {
                contains_code = false,
              },
            },
            ["symbols"] = {
              callback = "strategies.chat.slash_commands.symbols",
              description = "Insert symbols for a selected file",
              opts = {
                contains_code = true,
                provider = "default", -- default|telescope|mini_pick|fzf_lua
              },
            },
            ["terminal"] = {
              callback = "strategies.chat.slash_commands.terminal",
              description = "Insert terminal output",
              opts = {
                contains_code = false,
              },
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },
      adapters = {
        copilot = function() return require("codecompanion.adapters").extend("copilot", {}) end,
      },
    },
  },
}
