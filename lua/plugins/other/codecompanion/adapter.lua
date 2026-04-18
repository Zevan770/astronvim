return {

  {
    "olimorris/codecompanion.nvim",
    dev = true,
    -- see /home/hw770/.local/share/nvim/lazy/codecompanion.nvim/lua/codecompanion/config.lua:10
    opts = {
      interactions = {
        chat = {
          -- adapter = my_utils.is_nixos and "claude_code" or "qwen_code",
          adapter = "opencode",
        },
      },
      inline = {
        adapter = "copilot",
      },
      agent = {
        adapter = "copilot",
      },
      adapters = {
        acp = {
          opencode = function()
            return require("codecompanion.adapters").extend("opencode", {
              defaults = {
                timeout = 30000,
              },
            })
          end,
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              defaults = {
                timeout = 30000,
              },
            })
          end,
        },
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4.1",
              },
            },
          })
        end,
        claude37 = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.7-sonnet",
              },
            },
          })
        end,
      },
    },
  },
}
