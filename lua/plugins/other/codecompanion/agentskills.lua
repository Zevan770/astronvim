return {
  {
    "cairijun/codecompanion-agentskills.nvim",
    lazy = true,
    dependencies = {
      {
        "olimorris/codecompanion.nvim",
        dependencies = {
          "cairijun/codecompanion-agentskills.nvim",
        },
        opts = {
          extensions = {
            agentskills = {
              opts = {
                paths = {
                  -- "~/my-agent-skills", -- Single directory (non-recursive)
                  -- { "~/.config/nvim/skills", recursive = true }, -- Recursive search
                },
              },
            },
          },
        },
      },
    },
  },
}
