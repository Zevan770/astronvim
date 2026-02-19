return {
  {
    "ahkohd/buffer-sticks.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader><space>",
        function() BufferSticks.jump() end,
        desc = "Jump to buffer",
      },
      {
        "<leader>bc",
        function() BufferSticks.close() end,
        desc = "Close buffer",
      },
      -- {
      --   "fB",
      --   function()
      --     BufferSticks.list {
      --       action = function(buffer, leave)
      --         print("Selected: " .. buffer.name)
      --         leave()
      --       end,
      --     }
      --   end,
      --   desc = "Buffer picker",
      -- },
    },
    config = function()
      local sticks = require "buffer-sticks"
      sticks.setup {
        filter = { buftypes = { "terminal" } },
      }
      sticks.show()
    end,
  },
}
