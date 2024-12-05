---@type LazySpec
return {
  "Astronvim/astrocommunity",
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  {
    "karb94/neoscroll.nvim",
    -- enabled = false,
    opts = {

      mappings = { -- Keys to be mapped to their corresponding default scrolling animation
        -- "<C-u>",
        -- "<C-d>",
        "<C-b>",
        "<C-f>",
        -- "<C-y>",
        -- "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing = "cubic", -- Default easing function
      pre_hook = function(info)
        if info == "cursorline" then vim.wo.cursorline = false end
      end,
      post_hook = function(info)
        if info == "cursorline" then vim.wo.cursorline = true end
      end,
      performance_mode = false, -- Disable "Performance Mode" on all buffers.
      ignored_events = { -- Events ignored while scrolling
        "WinScrolled",
        "CursorMoved",
        "CursorHold",
      },
    },
    keys = function()
      local neoscroll = require "neoscroll"

      local function create_scroll_mapping(key, func)
        return {
          key,
          function() func { duration = 100 } end,
          mode = { "n", "v", "x" },
        }
      end

      return {
        create_scroll_mapping("<C-u>", neoscroll.ctrl_u),
        create_scroll_mapping("<C-d>", neoscroll.ctrl_d),
        create_scroll_mapping("<C-f>", neoscroll.ctrl_f),
        create_scroll_mapping("<C-b>", neoscroll.ctrl_b),
      }
      --   return {
      --     {
      --       "<C-u>",
      --       function() neoscroll.ctrl_u { duration = 100, info = "cursorline" } end,
      --       mode = { "n", "v", "x" },
      --     },
      --     {
      --       "<C-d>",
      --       function() neoscroll.ctrl_d { duration = 100, info = "cursorline" } end,
      --       mode = { "n", "v", "x" },
      --     },
      --     {
      --       "<C-f>",
      --       function() neoscroll.ctrl_f { duration = 100, info = "cursorline" } end,
      --       mode = { "n", "v", "x" },
      --     },
      --     {
      --       "<C-b>",
      --       function() neoscroll.ctrl_b { duration = 100, info = "cursorline" } end,
      --       mode = { "n", "v", "x" },
      --     },
      --   }
    end,
  },
}
