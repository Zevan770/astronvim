return {
  {
    -- "linkarzu/snipe.nvim",
    "leath-dub/snipe.nvim",
    -- enabled = false,
    keys = {
      {
        "<leader><space>",
        function() require("snipe").open_buffer_menu() end,
        desc = "Open Snipe buffer menu",
      },
      {
        "<leader>od",
        function() require("plugins.search.snipe.browser").open() end,
        desc = "open snipe file manager",
      },
    },
    config = function()
      local snipe = require "snipe"
      -- ~/.local/share/nvim/lazy/snipe.nvim/lua/snipe/config.lua:5
      snipe.setup(
        ---@type snipe.Config
        {
          ui = {
            position = "center",
            text_align = "file-first",
            preselect_current = true,
          },
          navigate = {
            leader = "<localleader>",
          },
        }
      )
    end,
  },
}
