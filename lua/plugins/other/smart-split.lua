return {
  "mrjones2014/smart-splits.nvim",
  keys = {
    {
      "<A-h>",
      function() require("smart-splits").move_cursor_left() end,
      desc = "Move to left split",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<A-j>",
      function() require("smart-splits").move_cursor_down() end,
      desc = "Move to below split",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<A-k>",
      function() require("smart-splits").move_cursor_up() end,
      desc = "Move to above split",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<A-l>",
      function() require("smart-splits").move_cursor_right() end,
      desc = "Move to right split",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<c-a-k>",
      function() require("smart-splits").resize_up() end,
      desc = "Resize split up",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<c-a-j>",
      function() require("smart-splits").resize_down() end,
      desc = "Resize split down",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<c-a-h>",
      function() require("smart-splits").resize_left() end,
      desc = "Resize split left",
      mode = { "n", "i", "v", "t" },
    },
    {
      "<c-a-l>",
      function() require("smart-splits").resize_right() end,
      desc = "Resize split right",
      mode = { "n", "i", "v", "t" },
    },
  },
}
