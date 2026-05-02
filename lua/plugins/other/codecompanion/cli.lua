return {
  {
    "olimorris/codecompanion.nvim",
    -- see /home/hw770/.local/share/nvim/lazy/codecompanion.nvim/lua/codecompanion/config.lua:10
    opts = {
      interactions = {
        cli = {
          agent = "opencode",
          agents = {
            opencode = {
              cmd = "opencode",
              args = {},
              description = "opencode",
              provider = "terminal",
            },
          },
        },
      },
    },
  },
}
