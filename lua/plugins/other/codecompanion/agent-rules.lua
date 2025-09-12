if true then return {} end
---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      -- other dependencies...
      "minusfive/codecompanion-agent-rules", -- replace with your actual repo
    },
    opts = {
      -- other codecompanion options...
      extensions = {
        agent_rules = {
          enabled = true,
          opts = {
            -- Optional: override defaults
            -- rules_filenames = {
            --   ".rules",
            --   "AGENT.md",
            --   -- Add your custom rule filenames here
            -- },
            debug = false,
          },
        },
      },
    },
  },
}
