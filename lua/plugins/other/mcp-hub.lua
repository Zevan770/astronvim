return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  enabled = not my_utils.is_windows,
  event = "User AstroFile",
  cmd = "MCPHub",
  build = "pnpm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  opts = {
    port = 3001,
    config = vim.fn.expand "~/mcpservers.json",
    log = {
      level = vim.log.levels.WARN,
      to_file = false,
      file_path = nil,
      prefix = "MCPHub",
    },
  },
  specs = {
    {
      "yetone/avante.nvim",
      optional = true,
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
  },
}
