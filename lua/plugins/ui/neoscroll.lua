-- if true then return {} end
---@type LazySpec
return {
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    -- enabled = false,
    --see ~/.local/share/nvim/lazy/neoscroll.nvim/lua/neoscroll/config.lua
    opts = {
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing = "linear", -- Default easing function
      pre_hook = function(info)
        if info == "cursorline" then vim.wo.cursorline = false end
        -- if vim.o.startofline then vim.cmd "normal! ^" end
      end,
      post_hook = function(info)
        if info == "cursorline" then
          vim.wo.cursorline = true
        elseif info == "center" then
          vim.cmd "normal! zz"
        end
      end,
      performance_mode = false, -- Disable "Performance Mode" on all buffers.
      ignored_events = { -- Events ignored while scrolling
        -- "WinScrolled",
        "CursorMoved",
        "CursorHold",
      },
    },
    keys = function()
      local neoscroll = require "neoscroll"

      local function create_scroll_mapping(key, func)
        return {
          key,
          function() func { duration = 50, info = "center" } end,
          mode = { "n", "v", "x" },
        }
      end

      return {
        create_scroll_mapping("<C-u>", neoscroll.ctrl_u),
        create_scroll_mapping("<C-d>", neoscroll.ctrl_d),
        create_scroll_mapping("<C-k>", neoscroll.ctrl_u),
        create_scroll_mapping("<C-j>", neoscroll.ctrl_d),
        create_scroll_mapping("<C-f>", neoscroll.ctrl_f),
        create_scroll_mapping("<PageDown>", neoscroll.ctrl_f),
        create_scroll_mapping("<C-b>", neoscroll.ctrl_b),
        create_scroll_mapping("<PageUp>", neoscroll.ctrl_b),
      }
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    cond = not my_utils.is_neovide and not my_utils.is_firenvim and not vim.env.KITTY_PID and not my_utils.is_vscode,
    -- enabled = false,
    -- see ~/.local/share/nvim/lazy/smear-cursor.nvim/lua/smear_cursor/config.lua
    opts = {
      hide_target_hack = true,
      cursor_color = "none",
      legacy_computing_symbols_support = true,
      smear_horizontally = true,
      smear_vertically = true,
      min_horizontal_distance_smear = 8,
      min_vertical_distance_smear = 3,
      smear_between_neighbor_lines = false,
    },
    specs = {
      -- disable mini.animate cursor
      {
        "echasnovski/mini.animate",
        optional = true,
        opts = {
          cursor = { enable = false },
        },
      },
    },
  },
}
