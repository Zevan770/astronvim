return {
  {
    "Zevan770/smart-splits.nvim",
    -- "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.move_cursor = true
      return opts
    end,
    keys = function()
      local directions = {
        h = "left",
        j = "down",
        k = "up",
        l = "right",
      }
      local keys = {}
      -- Move cursor
      for key, dir in pairs(directions) do
        table.insert(keys, {
          string.format("<A-%s>", key),
          function() require("smart-splits")["move_cursor_" .. dir]() end,
          desc = string.format("Move to %s split", dir),
          mode = { "n", "i", "t" },
        })
      end
      -- Resize split
      for key, dir in pairs(directions) do
        table.insert(keys, {
          string.format("<A-S-%s>", key),
          function() require("smart-splits")["resize_" .. dir]() end,
          desc = string.format("Resize split %s", dir),
          mode = { "n", "i", "t" },
        })
      end
      -- Swap buffer (use move_mouse param)
      -- for key, dir in pairs(directions) do
      --   table.insert(keys, {
      --     string.format("<A-C-%s>", key),
      --     function() require("smart-splits")["swap_buf_" .. dir] { move_mouse = true } end,
      --     desc = string.format("Swap buffer %s", dir),
      --     mode = { "n", "i", "t" },
      --   })
      -- end
      return keys
    end,
  }
}

