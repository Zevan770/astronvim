---@diagnostic disable: missing-fields
-- if true then return {} end
local markdown_ft = require("utils.filetype").markdown_like
return {
  {
    "roodolv/markdown-toggle.nvim",
    config = function()
      require("markdown-toggle").setup {
        -- If true, the auto-setup for the default keymaps is enabled
        use_default_keymaps = false,
        -- The keymaps are valid only for these filetypes
        filetypes = markdown_ft,

        -- The list marks table used in cycle-mode (list_table[1] is used as the default list-mark)
        list_table = { "-", "+", "*", "=" },
        -- Cycle the marks in user-defined table when toggling lists
        cycle_list_table = false,

        -- The checkbox marks table used in cycle-mode (box_table[1] is used as the default checked-state)
        box_table = { "x", "~", "!", ">" },
        -- Cycle the marks in user-defined table when toggling checkboxes
        cycle_box_table = false,
        -- A bullet list is toggled before turning into a checkbox (similar to how it works in Obsidian).
        list_before_box = false,

        -- The heading marks table used in `markdown-toggle.heading`
        heading_table = { "#", "##", "###", "####", "#####" },

        -- Skip blank lines and headings in Visual mode (except for `quote()`)
        enable_blankhead_skip = true,
        -- Insert an indented quote for new lines within quoted text
        -- enable_inner_indent = false,
        -- Toggle only unmarked lines first
        enable_unmarked_only = true,
        -- Automatically continue lists on new lines
        enable_autolist = true,
        -- Maintain checkbox state when continuing lists
        enable_auto_samestate = false,
        -- Dot-repeat for toggle functions in Normal mode
        enable_dot_repeat = true,
      }
    end,
    keys = function()
      local toggle = require "markdown-toggle"
      ---@type LazyKeys
      return {
        -- stylua: ignore start
        -- Settings mappings
        { "<localleader>uu", function() toggle.switch_unmarked_only() end,     mode = "n", desc = "Toggle unmarked-only mode",    ft = markdown_ft },
        { "<localleader>ub", function() toggle.switch_blankhead_skip() end,    mode = "n", desc = "Toggle blankhead-skip mode",   ft = markdown_ft },
        { "<localleader>us", function() toggle.switch_auto_samestate() end,    mode = "n", desc = "Toggle auto-samestate mode",   ft = markdown_ft },
        { "<localleader>ul", function() toggle.switch_cycle_list_table() end,  mode = "n", desc = "Toggle cycle-list-table mode", ft = markdown_ft },
        { "<localleader>ux", function() toggle.switch_cycle_box_table() end,   mode = "n", desc = "Toggle cycle-box-table mode",  ft = markdown_ft },
        { "<localleader>uc", function() toggle.switch_list_before_box() end,   mode = "n", desc = "Toggle list-before-box mode",  ft = markdown_ft },

        -- Normal mode with dot-repeat
        { "<localleader>q",  toggle.quote_dot,                                 mode = "n", desc = "Toggle quote",                 ft = markdown_ft,  expr = true  },
        { "<localleader>l",  toggle.list_dot,                                  mode = "n", desc = "Toggle list",                  ft = markdown_ft,  expr = true  },
        { "<localleader>s",  toggle.list_cycle_dot,                            mode = "n", desc = "Toggle list cycle",            ft = markdown_ft,  expr = true  },
        { "<localleader>n",  toggle.olist_dot,                                 mode = "n", desc = "Toggle ordered list",          ft = markdown_ft,  expr = true  },
        { "<localleader>x",  toggle.checkbox_dot,                              mode = "n", desc = "Toggle checkbox",              ft = markdown_ft,  expr = true  },
        { "<localleader>c",  toggle.checkbox_cycle_dot,                        mode = "n", desc = "Toggle checkbox cycle",        ft = markdown_ft,  expr = true  },
        { "<localleader>h",  toggle.heading_dot,                               mode = "n", desc = "Toggle heading",               ft = markdown_ft,  expr = true  },

        -- Visual mode without dot-repeat
        { "<localleader>q",  function() toggle.quote() end,                    mode = "x", desc = "Toggle quote",                 ft = markdown_ft },
        { "<localleader>l",  function() toggle.list() end,                     mode = "x", desc = "Toggle list",                  ft = markdown_ft },
        { "<localleader>s",  function() toggle.list_cycle() end,               mode = "x", desc = "Toggle list cycle",            ft = markdown_ft },
        { "<localleader>n",  function() toggle.olist() end,                    mode = "x", desc = "Toggle ordered list",          ft = markdown_ft },
        { "<localleader>x",  function() toggle.checkbox() end,                 mode = "x", desc = "Toggle checkbox",              ft = markdown_ft },
        { "<localleader>c",  function() toggle.checkbox_cycle() end,           mode = "x", desc = "Toggle checkbox cycle",        ft = markdown_ft },
        { "<localleader>h",  function() toggle.heading() end,                  mode = "x", desc = "Toggle heading",               ft = markdown_ft },

        -- Auto-list mappings
        { "O",               function() toggle.autolist_up() end,              mode = "n", desc = "Add list item above",          ft = markdown_ft },
        { "o",               function() toggle.autolist_down() end,            mode = "n", desc = "Add list item below",          ft = markdown_ft },
        { "<CR>",            function() toggle.autolist_cr() end,              mode = "i", desc = "Continue list item",           ft = markdown_ft },
        -- stylua: ignore end
      }
    end,
  },
}
