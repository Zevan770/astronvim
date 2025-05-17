if true then return {} end
---@type LazySpec
return {
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    keys = function(_, keys)
      local vscode = require "vscode"
      return {
        {
          "I",
          function() require("vscode-multi-cursor").start_left { no_selection = true } end,
          mode = "x",
        },
        {
          "I",
          function()
            if #require("vscode-multi-cursor.state").cursors == 0 then return "I" end
            require("vscode-multi-cursor").start_left()
            return "<Ignore>"
          end,
          mode = "n",
          expr = true,
        },
        {
          "A",
          function() require("vscode-multi-cursor").start_right { no_selection = true } end,
          mode = "x",
        },
        {
          "A",
          function()
            if #require("vscode-multi-cursor.state").cursors == 0 then return "A" end
            require("vscode-multi-cursor").start_right()
            return "<Ignore>"
          end,
          mode = "n",
          expr = true,
        },
        {
          "c",
          function()
            if vim.fn.mode() == "\x16" then
              require("vscode-multi-cursor").start_right()
              require("vscode").action "deleteLeft"
              return "<Ignore>"
            else
              return "c"
            end
          end,
          mode = "x",
          expr = true,
        },
        {
          "<Leader>v",
          function() return require("vscode-multi-cursor").create_cursor() end,
          mode = { "n", "x" },
          expr = true,
          desc = "Create Cursor",
        },
        -- {
        --   "<Leader>ms",
        --   function()
        --     if vim.api.nvim_get_hl(0, { name = "FlashLabelUnselected" }).bg == nil then
        --       vim.api.nvim_set_hl(
        --         0,
        --         "FlashLabelUnselected",
        --         { fg = "#b9bbc4", bg = "#bd0c69", italic = true, bold = true }
        --       )
        --     end
        --     keymap.toggle_cursor_by_flash()
        --   end,
        --   mode = "n",
        --   desc = "Create cursor using flash",
        -- },
        {
          "<Leader>vs",
          function() require("vscode-multi-cursor").flash_char() end,
          mode = "n",
          desc = "Create cursor using flash",
        },
        {
          "<Leader>vv",
          function() require("vscode-multi-cursor").flash_word() end,
          mode = "n",
          desc = "Create selection using flash",
        },
        {
          "<Esc>",
          function()
            if #require("vscode-multi-cursor.state").cursors ~= 0 then
              require("vscode-multi-cursor").cancel()
              return "<Ignore>"
            else
              return "<Cmd>nohlsearch|diffupdate|normal! <C-L><CR><Esc>"
            end
          end,
          expr = true,
          mode = "n",
          desc = "Cancel/Clear All Cursors",
        },
        {
          "[c",
          function() require("vscode-multi-cursor").prev_cursor() end,
          mode = "n",
          desc = "Goto Prev Cursor",
        },
        {
          "]c",
          function() require("vscode-multi-cursor").next_cursor() end,
          mode = "n",
          desc = "Goto Next Cursor",
        },
        {
          "<A-N>",
          function()
            vscode.with_insert(function() vscode.action "editor.action.addSelectionToNextFindMatch" end)
          end,
          mode = { "n", "v", "i" },
          desc = "Select Next Find Match",
        },
        {
          "gL",
          function() require("vscode-multi-cursor").selectHighlights() end,
          mode = { "n", "x", "i" },
          desc = "Select All Find Match",
        },
      }
    end,
    opts = {
      default_mappings = false,
    },
    cond = not not vim.g.vscode,
  },
}
