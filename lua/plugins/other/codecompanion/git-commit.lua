---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "jinzhongjia/codecompanion-gitcommit.nvim",
    },
    opts = {
      extensions = {
        gitcommit = {
          callback = "codecompanion._extensions.gitcommit",
          opts = {
            -- Basic configuration
            adapter = "copilot", -- LLM adapter
            model = "gpt-4.1", -- Model name
            languages = { "English", "Chinese" }, -- Supported languages

            -- File filtering (optional)
            exclude_files = {
              "*.pb.go",
              "*.min.js",
              "*.min.css",
              "package-lock.json",
              "yarn.lock",
              "*.log",
              "dist/*",
              "build/*",
              ".next/*",
              "node_modules/*",
              "vendor/*",
            },

            -- Buffer integration
            buffer = {
              enabled = true, -- Enable gitcommit buffer keymaps
              keymap = "<leader>cgc", -- Keymap for generating commit messages
              auto_generate = true, -- Auto-generate on buffer enter
              auto_generate_delay = 200, -- Auto-generation delay (ms)
              skip_auto_generate_on_amend = true, -- Skip auto-generation during git commit --amend
            },

            -- Feature toggles
            add_slash_command = true, -- Add /gitcommit slash command
            add_git_tool = true, -- Add @{git_read} and @{git_edit} tools
            enable_git_read = true, -- Enable read-only Git operations
            enable_git_edit = true, -- Enable write-access Git operations
            enable_git_bot = true, -- Enable @{git_bot} tool group (requires both read/write enabled)
            add_git_commands = true, -- Add :CodeCompanionGitCommit commands
            git_tool_auto_submit_errors = false, -- Auto-submit errors to LLM
            git_tool_auto_submit_success = true, -- Auto-submit success to LLM
            gitcommit_select_count = 100, -- Number of commits shown in /gitcommit

            -- Commit history context (optional)
            use_commit_history = true, -- Enable commit history context
            commit_history_count = 10, -- Number of recent commits for context
          },
        },
      },
    },
  },
}
