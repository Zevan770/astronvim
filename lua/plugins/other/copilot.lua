if true then return {} end
---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      server = {
        type = "binary",
        custom_server_filepath = "copilot-language-server",
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "fang2hou/blink-copilot",
    specs = {
      {
        "saghen/blink.cmp",
        optional = true,
        dependencies = { "fang2hou/blink-copilot" },
        opts = {
          sources = {
            default = { "copilot" },
            providers = {
              copilot = {
                name = "copilot",
                module = "blink-copilot",
                -- score_offset = 100,
                async = true,
                override = {
                  get_trigger_characters = require("utils.blink").get_trigger_characters,
                },
              },
            },
          },
        },
      },
    },
  },
}
