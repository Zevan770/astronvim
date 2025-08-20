---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      {
        "Davidyz/codecompanion-dap.nvim",
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
    },
    opts = {
      extensions = {
        dap = {
          enabled = true,
          opts = {
            -- show the tool group instead of individual tools in the chat buffer
            collapse_tools = true,
            interval_ms = 1000,
            winfixbuf = true,

            tool_opts = {
              evaluate = {
                requires_approval = true,
              },
              source = {
                -- load the file content from the
                -- filesystem when possible.
                prefer_filesystem = true,
              },
            },
          },
        },
      },
    },
  },
}
