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
        enable_inner_indent = false,
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
  },
  {
    "AstroNvim/astrocore",
    optional = true,
    opts = function(_, opts)
      opts.autocmds = opts.autocmds or {}
      opts.autocmds.markdown_toggle_maps = {
        {
          event = "FileType",
          pattern = "markdown",
          callback = function(args)
            local toggle = require "markdown-toggle"
            local map = vim.keymap.set
            local buffer = args.buf

            -- stylua: ignore start
            -- Settings mappings
            map("n", "<localleader>uu", toggle.switch_unmarked_only,    { desc = "Toggle unmarked-only mode",    buffer = buffer })
            map("n", "<localleader>ub", toggle.switch_blankhead_skip,   { desc = "Toggle blankhead-skip mode",   buffer = buffer })
            map("n", "<localleader>ui", toggle.switch_inner_indent,     { desc = "Toggle inner-indent mode",     buffer = buffer })
            map("n", "<localleader>us", toggle.switch_auto_samestate,   { desc = "Toggle auto-samestate mode",   buffer = buffer })
            map("n", "<localleader>ul", toggle.switch_cycle_list_table, { desc = "Toggle cycle-list-table mode", buffer = buffer })
            map("n", "<localleader>ux", toggle.switch_cycle_box_table,  { desc = "Toggle cycle-box-table mode",  buffer = buffer })
            map("n", "<localleader>uc", toggle.switch_list_before_box,  { desc = "Toggle list-before-box mode",  buffer = buffer })

            -- Normal mode with dot-repeat
            map("n", "<localleader>q",  toggle.quote_dot,               { desc = "Toggle quote",                 buffer = buffer, expr = true })
            map("n", "<localleader>l",  toggle.list_dot,                { desc = "Toggle list",                  buffer = buffer, expr = true })
            map("n", "<localleader>s",  toggle.list_cycle_dot,          { desc = "Toggle list cycle",            buffer = buffer, expr = true })
            map("n", "<localleader>n",  toggle.olist_dot,               { desc = "Toggle ordered list",          buffer = buffer, expr = true })
            map("n", "<localleader>x",  toggle.checkbox_dot,            { desc = "Toggle checkbox",              buffer = buffer, expr = true })
            map("n", "<localleader>c",  toggle.checkbox_cycle_dot,      { desc = "Toggle checkbox cycle",        buffer = buffer, expr = true })
            map("n", "<localleader>h",  toggle.heading_dot,             { desc = "Toggle heading",               buffer = buffer, expr = true })

            -- Visual mode without dot-repeat
            map("x", "<localleader>q",  toggle.quote,                   { desc = "Toggle quote",                 buffer = buffer })
            map("x", "<localleader>l",  toggle.list,                    { desc = "Toggle list",                  buffer = buffer })
            map("x", "<localleader>s",  toggle.list_cycle,              { desc = "Toggle list cycle",            buffer = buffer })
            map("x", "<localleader>n",  toggle.olist,                   { desc = "Toggle ordered list",          buffer = buffer })
            map("x", "<localleader>x",  toggle.checkbox,                { desc = "Toggle checkbox",              buffer = buffer })
            map("x", "<localleader>c",  toggle.checkbox_cycle,          { desc = "Toggle checkbox cycle",        buffer = buffer })
            map("x", "<localleader>h",  toggle.heading,                 { desc = "Toggle heading",               buffer = buffer })

            -- Auto-list mappings
            map("n", "O",               toggle.autolist_up,             { desc = "Add list item above",          buffer = buffer })
            map("n", "o",               toggle.autolist_down,           { desc = "Add list item below",          buffer = buffer })
            map("i", "<CR>",            toggle.autolist_cr,             { desc = "Continue list item",           buffer = buffer })
            -- stylua: ignore end
          end,
        },
      }
      return opts
    end,
  },
}
