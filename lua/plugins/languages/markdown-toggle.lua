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
        filetypes = { "markdown", "markdown.mdx" },

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
      return {
        -- stylua: ignore start
        -- Settings mappings
        { mode = "n", "<localleader>uu", function() toggle.switch_unmarked_only() end,     desc = "Toggle unmarked-only mode",    ft = markdown_ft },
        { mode = "n", "<localleader>ub", function() toggle.switch_blankhead_skip() end,    desc = "Toggle blankhead-skip mode",   ft = markdown_ft },
        { mode = "n", "<localleader>us", function() toggle.switch_auto_samestate() end,    desc = "Toggle auto-samestate mode",   ft = markdown_ft },
        { mode = "n", "<localleader>ul", function() toggle.switch_cycle_list_table() end,  desc = "Toggle cycle-list-table mode", ft = markdown_ft },
        { mode = "n", "<localleader>ux", function() toggle.switch_cycle_box_table() end,   desc = "Toggle cycle-box-table mode",  ft = markdown_ft },
        { mode = "n", "<localleader>uc", function() toggle.switch_list_before_box() end,   desc = "Toggle list-before-box mode",  ft = markdown_ft },

        -- Normal mode with dot-repeat
        { mode = "n", "<localleader>q",  function() toggle.quote_dot() end,                desc = "Toggle quote",                 ft = markdown_ft, expr = true },
        { mode = "n", "<localleader>l",  function() toggle.list_dot() end,                 desc = "Toggle list",                  ft = markdown_ft, expr = true },
        { mode = "n", "<localleader>s",  function() toggle.list_cycle_dot() end,           desc = "Toggle list cycle",            ft = markdown_ft, expr = true },
        { mode = "n", "<localleader>n",  function() toggle.olist_dot() end,                desc = "Toggle ordered list",          ft = markdown_ft, expr = true },
        { mode = "n", "<localleader>x",  function() toggle.checkbox_dot() end,             desc = "Toggle checkbox",              ft = markdown_ft, expr = true },
        { mode = "n", "<localleader>c",  function() toggle.checkbox_cycle_dot() end,       desc = "Toggle checkbox cycle",        ft = markdown_ft, expr = true },
        { mode = "n", "<localleader>h",  function() toggle.heading_dot() end,              desc = "Toggle heading",               ft = markdown_ft, expr = true },

        -- Visual mode without dot-repeat
        { mode = "x", "<localleader>q",  function() toggle.quote() end,                    desc = "Toggle quote",                 ft = markdown_ft },
        { mode = "x", "<localleader>l",  function() toggle.list() end,                     desc = "Toggle list",                  ft = markdown_ft },
        { mode = "x", "<localleader>s",  function() toggle.list_cycle() end,               desc = "Toggle list cycle",            ft = markdown_ft },
        { mode = "x", "<localleader>n",  function() toggle.olist() end,                    desc = "Toggle ordered list",          ft = markdown_ft },
        { mode = "x", "<localleader>x",  function() toggle.checkbox() end,                 desc = "Toggle checkbox",              ft = markdown_ft },
        { mode = "x", "<localleader>c",  function() toggle.checkbox_cycle() end,           desc = "Toggle checkbox cycle",        ft = markdown_ft },
        { mode = "x", "<localleader>h",  function() toggle.heading() end,                  desc = "Toggle heading",               ft = markdown_ft },

        -- Auto-list mappings
        { mode = "n", "O",               function() toggle.autolist_up() end,              desc = "Add list item above",          ft = markdown_ft },
        { mode = "n", "o",               function() toggle.autolist_down() end,            desc = "Add list item below",          ft = markdown_ft },
        { mode = "i", "<CR>",            function() toggle.autolist_cr() end,              desc = "Continue list item",           ft = markdown_ft },
        -- stylua: ignore end
      }
    end,
  },
}
