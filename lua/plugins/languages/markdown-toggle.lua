if true then return {} end
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
        {mode = "n", "<localleader>uu", toggle.switch_unmarked_only,     desc = "Toggle unmarked-only mode",    ft = "markdown" },
        {mode = "n", "<localleader>ub", toggle.switch_blankhead_skip,    desc = "Toggle blankhead-skip mode",   ft = "markdown" },
        {mode = "n", "<localleader>us", toggle.switch_auto_samestate,    desc = "Toggle auto-samestate mode",   ft = "markdown" },
        {mode = "n", "<localleader>ul", toggle.switch_cycle_list_table,  desc = "Toggle cycle-list-table mode", ft = "markdown" },
        {mode = "n", "<localleader>ux", toggle.switch_cycle_box_table,   desc = "Toggle cycle-box-table mode",  ft = "markdown" },
        {mode = "n", "<localleader>uc", toggle.switch_list_before_box,   desc = "Toggle list-before-box mode",  ft = "markdown" },

        -- Normal mode with dot-repeat
        {mode = "n", "<localleader>q",  toggle.quote_dot,                desc = "Toggle quote",                 ft = "markdown",expr = true },
        {mode = "n", "<localleader>l",  toggle.list_dot,                 desc = "Toggle list",                  ft = "markdown",expr = true },
        {mode = "n", "<localleader>s",  toggle.list_cycle_dot,           desc = "Toggle list cycle",            ft = "markdown",expr = true },
        {mode = "n", "<localleader>n",  toggle.olist_dot,                desc = "Toggle ordered list",          ft = "markdown",expr = true },
        {mode = "n", "<localleader>x",  toggle.checkbox_dot,             desc = "Toggle checkbox",              ft = "markdown",expr = true },
        {mode = "n", "<localleader>c",  toggle.checkbox_cycle_dot,       desc = "Toggle checkbox cycle",        ft = "markdown",expr = true },
        {mode = "n", "<localleader>h",  toggle.heading_dot,              desc = "Toggle heading",               ft = "markdown",expr = true },

        -- Visual mode without dot-repeat
        {mode = "x", "<localleader>q",  toggle.quote,                    desc = "Toggle quote",                 ft = "markdown" },
        {mode = "x", "<localleader>l",  toggle.list,                     desc = "Toggle list",                  ft = "markdown" },
        {mode = "x", "<localleader>s",  toggle.list_cycle,               desc = "Toggle list cycle",            ft = "markdown" },
        {mode = "x", "<localleader>n",  toggle.olist,                    desc = "Toggle ordered list",          ft = "markdown" },
        {mode = "x", "<localleader>x",  toggle.checkbox,                 desc = "Toggle checkbox",              ft = "markdown" },
        {mode = "x", "<localleader>c",  toggle.checkbox_cycle,           desc = "Toggle checkbox cycle",        ft = "markdown" },
        {mode = "x", "<localleader>h",  toggle.heading,                  desc = "Toggle heading",               ft = "markdown" },

        -- Auto-list mappings
        {mode = "n", "O",               toggle.autolist_up,              desc = "Add list item above",          ft = "markdown" },
        {mode = "n", "o",               toggle.autolist_down,            desc = "Add list item below",          ft = "markdown" },
        {mode = "i", "<CR>",            toggle.autolist_cr,              desc = "Continue list item",           ft = "markdown" },
        -- stylua: ignore end
      }
    end,
  },
}
