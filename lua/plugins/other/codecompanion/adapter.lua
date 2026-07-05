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
        adapter = "opencode_go",
      },
      agent = {
        adapter = "opencode_go",
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
          opencode_go = function()
            return require("codecompanion.adapters").extend("deepseek", {
              url = "https://opencode.ai/zen/go/v1/chat/completions",
              env = {
                api_key = "OPENCODE_GO_API_KEY",
                -- api_key = "cmd:rbw get opencode_go",
              },
              schema = {
                model = {
                  default = "deepseek-v4-flash",
                },
              },
            })
          end,
          minimax = function()
            return require("codecompanion.adapters").extend("anthropic", {
              url = "https://api.minimaxi.com/anthropic/v1/messages",
              schema = {
                model = {
                  default = "MiniMax-M2.7",
                  choices = {
                    ["MiniMax-M2.7"] = {
                      formatted_name = "MiniMax-M2.7",
                      meta = { context_window = 200000, max_tokens = 64000 },
                      opts = { can_manage_context = false, has_vision = false },
                    },
                  },
                },
              },
            })
          end,
        },
      },
    },
  },
}
