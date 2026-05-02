return {
  {
    "olimorris/codecompanion.nvim",
    -- see /home/hw770/.local/share/nvim/lazy/codecompanion.nvim/lua/codecompanion/config.lua:10
    opts = {
      interactions = {
        chat = {
          -- adapter = my_utils.is_nixos and "claude_code" or "qwen_code",
          adapter = "opencode",
        },
      },
      inline = {
        adapter = "minimax",
      },
      agent = {
        adapter = "minimax",
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
        http = {
          minimax = function()
            return require("codecompanion.adapters").extend("anthropic", {
              schema = {
                model = {
                  default = "MiniMax-M2.7",
                },
              },
            })
          end,
        },
      },
    },
  },
}
