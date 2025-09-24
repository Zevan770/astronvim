return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  -- event = "User AstroFile",
  cmd = "MCPHub",
  build = "pnpm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  ---@module "mcphub"
  ---@type MCPHub.Config
  opts = {
    port = my_utils.is_windows and 3003 or 3001,
    auto_approve = true, -- Auto approve mcp tool calls
    auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
    config = vim.fn.expand "~/.config/mcphub/servers.json", -- Default config location
    extensions = {
      avante = {
        make_slash_commands = true, -- make /slash commands from MCP server prompts
      },
    },
    log = {
      level = vim.log.levels.WARN,
      to_file = false,
      file_path = nil,
      prefix = "MCPHub",
    },
  },
  keys = {
    {
      "<leader>om",
      "<Cmd>MCPHub<CR>",
      desc = "MCPHub",
      mode = { "n", "v" },
    },
  },
  specs = {
    {
      "yetone/avante.nvim",
      optional = true,
      dependencies = { "mcphub.nvim" },
      opts = {
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub:get_active_servers_prompt()
        end,
        -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
        custom_tools = function()
          return {
            require("mcphub.extensions.avante").mcp_tool(),
          }
        end,
      },
    },
    {
      "olimorris/codecompanion.nvim",
      dependencies = { "mcphub.nvim" },
      opts = {
        extensions = {
          mcphub = {
            enabled = true,
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
              make_vars = true, -- make chat #variables from MCP server resources
              make_slash_commands = true, -- make /slash_commands from MCP server prompts
            },
          },
        },
      },
    },
  },
}
