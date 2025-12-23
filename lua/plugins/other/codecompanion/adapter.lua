return {

  {
    "olimorris/codecompanion.nvim",
    opts = {
      interactions = {
        chat = {
          adapter = my_utils.is_nixos and "claude_code" or "qwen_code",
          -- adapter = "claude_code",
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
          claude_code = function() return require("codecompanion.adapters").extend("claude_code", {}) end,
          qwen_code = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              commands = {
                default = {
                  "qwen",
                  "--experimental-acp",
                },
                yolo = {
                  "qwen",
                  "--yolo",
                  "--experimental-acp",
                },
              },
              defaults = {
                auth_method = "openai",
                timeout = 60000, -- 20 seconds
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
