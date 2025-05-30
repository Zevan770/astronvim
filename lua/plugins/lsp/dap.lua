return {
  {
    "LiadOz/nvim-dap-repl-highlights",
    lazy = true,
    enabled = not my_utils.is_windows,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "LiadOz/nvim-dap-repl-highlights", opts = {} },
        opts = function(_, opts)
          if opts.ensure_installed ~= "all" then
            opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "dap_repl" })
          end
        end,
      },
    },
  },
  {
    "igorlfs/nvim-dap-view",
    lazy = true,
    opts = {},
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>d"] = vim.tbl_get(opts, "_map_sections", "d")
          maps.n["<Leader>dE"] = { function() require("dap-view").add_expr() end, desc = "Add expression" }
          maps.n["<Leader>du"] = { function() require("dap-view").toggle() end, desc = "Toggle Debugger UI" }
        end,
      },
      {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = "igorlfs/nvim-dap-view",
        opts = function()
          local dap, dap_view = require "dap", require "dap-view"
          dap.listeners.after.event_initialized.dapview_config = function() dap_view.open() end
          dap.listeners.before.event_terminated.dapview_config = function() dap_view.close() end
          dap.listeners.before.event_exited.dapview_config = function() dap_view.close() end
        end,
      },
      { "rcarriga/nvim-dap-ui", enabled = false },
    },
    -- config = function(_, opts)
    --   local dap, dv = require "dap", require "dap-view"
    --   dv.setup(opts)
    --
    --   dap.listeners.before.attach["dap-view-config"] = dv.open
    --   dap.listeners.before.launch["dap-view-config"] = dv.open
    --   dap.listeners.before.event_terminated["dap-view-config"] = dv.close
    --   dap.listeners.before.event_exited["dap-view-config"] = dv.close
    -- end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = "mfussenegger/nvim-dap",
    opts = {
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      only_first_definition = false,
      all_references = false,
    },
    keys = {
      {
        "<leader>dv",
        function() require("nvim-dap-virtual-text").toggle() end,
        desc = "󱂬 Toggle virtual text",
      },
    },
    config = function(_, opts)
      local dapVirtText = require "nvim-dap-virtual-text"
      dapVirtText.setup(opts)

      -- auto-disable/enable
      require("dap").listeners.after.disconnect.dapVirtText = dapVirtText.disable
    end,
    init = function()
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        desc = "User: Change `NvimDapVirtualText` color",
        callback = function() vim.api.nvim_set_hl(0, "NvimDapVirtualText", { link = "DiagnosticSignInfo" }) end,
      })
    end,
  },
}
