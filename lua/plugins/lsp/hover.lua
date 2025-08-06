---@type LazySpec
return {

  {
    "lewis6991/hover.nvim",
    opts = {
      init = function()
        require "hover.providers.lsp"
        require "hover.providers.man"
        require "hover.providers.dap"
        require "hover.providers.diagnostic"
        require "hover.providers.fold_preview"
        require "hover.providers.jira"
      end,
      preview_opts = {
        border = "rounded",
      },
      preview_window = false,
      title = true,
      mouse_providers = {
        "LSP",
      },
      mouse_delay = 1000,
    },
    keys = {
      {
        "gk",
        function() require("hover").hover() end,
        desc = "Trigger hover.",
        mode = "n",
        noremap = true,
      },
      {
        "[h",
        function() require("hover").hover_switch "previous" end,
        desc = "Previous hover provider.",
        mode = "n",
        noremap = true,
      },
      {
        "]h",
        function() require("hover").hover_switch "next" end,
        desc = "Next hover provider.",
        mode = "n",
        noremap = true,
      },
    },
  },
}
