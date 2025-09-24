---@type LazySpec
return {
  {
    "ravitemer/codecompanion-history.nvim",
    keys = {
      {
        "<leader>ch",
        "<cmd>CodeCompanionHistory<cr>",
        desc = "Code Companion - History",
      },
    },
    specs = {
      {
        "olimorris/codecompanion.nvim",
        dependencies = {
          "Davidyz/VectorCode",
        },
        opts = {
          extensions = {
            history = {
              enabled = true,
              -- ~/.local/share/nvim/lazy/codecompanion-history.nvim/doc/codecompanion-history.txt:126
              ---@module "codecompanion._extensions.history"
              ---@type CodeCompanion.History.Opts
              opts = {
                -- Keymap to open history from chat buffer (default: gh)
                keymap = "<localleader>h",
                -- Keymap to save the current chat manually (when auto_save is disabled)
                save_chat_keymap = "<C-s>",
                -- Save all chats by default (disable to save only manually using 'sc')
                auto_save = true,
                -- Number of days after which chats are automatically deleted (0 to disable)
                expiration_days = 0,
                -- Picker interface ("telescope" or "snacks" or "default")
                picker = "snacks",
                -- Automatically generate titles for new chats
                auto_generate_title = true,
                ---On exiting and entering neovim, loads the last chat on opening chat
                continue_last_chat = false,
                ---When chat is cleared with `gx` delete the chat from history
                delete_on_clearing_chat = false,
                ---Directory path to save the chats
                dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
                ---Enable detailed logging for history extension
                enable_logging = false,

                --#region summary
                summary = {
                  create_summary_keymap = "<localleader>sc",
                  browse_summaries_keymap = "<localleader>sb",
                  preview_summary_keymap = "<localleader>sp",

                  generation_opts = {
                    -- Use specific adapter for summaries (optional)
                    adapter = nil, -- defaults to current chat adapter
                    -- Use specific model for summaries (optional)
                    model = nil, -- defaults to current chat model
                    -- Context size for summarization (default: 90000)
                    context_size = 90000,
                    -- Include slash command content (default: true)
                    include_references = true,
                    -- Include tool outputs (default: true)
                    include_tool_outputs = true,
                    -- Custom system prompt (optional)
                    system_prompt = nil,
                  },
                },
                --#endregion
              },
            },
          },
        },
      },
    },
  },
}
