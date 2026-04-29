if true then return {} end
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
    opts = {
      filter = { buftypes = { "terminal" } },
      position = "center",
    },
  },
}
