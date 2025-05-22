---@type LazySpec
return {
  {
    "j-hui/fidget.nvim",
    event = "UIEnter",
    enabled = false,
    opts = {
      -- Options related to LSP progress subsystem
      progress = {
        poll_rate = 0, -- How and when to poll for progress messages
        suppress_on_insert = false, -- Suppress new messages while in insert mode
        ignore_done_already = false, -- Ignore new tasks that are already complete
        ignore_empty_message = false, -- Ignore new tasks that don't contain a message
        -- Clear notification group when LSP server detaches
        clear_on_detach = function(client_id)
          local client = vim.lsp.get_client_by_id(client_id)
          return client and client.name or nil
        end,
        -- How to get a progress message's notification group key
        notification_group = function(msg) return msg.lsp_client.name end,
        ignore = {}, -- List of LSP servers to ignore

        -- Options related to Neovim's built-in LSP client
        lsp = {
          progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
          log_handler = false, -- Log `$/progress` handler invocations (for debugging)
        },
      },

      -- Options related to notification subsystem
      notification = {
        window = {
          winblend = 0,
        },
        poll_rate = 10, -- How frequently to update and render notifications
        -- filter = vim.log.levels.INFO, -- Minimum notifications level
        history_size = 128, -- Number of removed messages to retain in history
        override_vim_notify = false, -- Automatically override vim.notify() with Fidget
        -- How to configure notification groups when instantiated
        -- configs = { default = require("fidget.notification").default_config },
        -- Conditionally redirect notifications to another backend
        redirect = function(msg, level, opts)
          if opts and opts.on_open then
            return pcall(function() require("snacks.notifier").notify(msg, level, opts) end)
          end
        end,
      },

      -- Options related to logging
      logger = {
        level = vim.log.levels.WARN, -- Minimum logging level
        max_size = 10000, -- Maximum log file size, in KB
        float_precision = 0.01, -- Limit the number of decimals displayed for floats
        -- Where Fidget writes its logs to
        path = string.format("%s/fidget.nvim.log", vim.fn.stdpath "cache"),
      },
    },
    specs = {
      {
        "telescope.nvim",
        optional = true,
        dependencies = {
          "j-hui/fidget.nvim",
        },
        opts = function() require("telescope").load_extension "fidget" end,
      },
      -- {
      --   "folke/snacks.nvim",
      --   optional = true,
      --   opts = {
      --     notifier = { enabled = false },
      --   },
      -- },
    },
  },
}
