-- TODO: disable this until https://github.com/huacnlee/autocorrect/pull/291 is merged or
-- I make my own flake of it work successfully.
-- if my_utils.is_windows then vim.lsp.enable "autocorrect" end
vim.lsp.enable "rumdl"

local markdown_ft = require("utils.filetype").markdown_like
local render_md_on_ft = require("astrocore").list_insert_unique(markdown_ft, { "gitcommit" })
local markview_on_ft = require("astrocore").list_insert_unique(markdown_ft, { "html", "yaml" })

---@type LazySpec
return {
  {
    "Myzel394/easytables.nvim",
    ft = markdown_ft,
    cmd = {
      "EasyTablesCreateNew",
      "EasyTablesImportThisTable",
    },
    opts = {
      table = {
        -- Whether to enable the header by default
        header_enabled_by_default = true,
        window = {
          preview_title = "Table Preview",
          prompt_title = "Cell content",
          -- Either "auto" to automatically size the window, or a string
          -- in the format of "<width>x<height>" (e.g. "20x10")
          size = "auto",
        },
        cell = {
          -- Min width of a cell (excluding padding)
          min_width = 3,
          -- Filler character for empty cells
          filler = " ",
          align = "left",
        },
      },
      export = {
        markdown = {
          -- Padding around the cell content, applied BOTH left AND right
          -- E.g: padding = 1, content = "foo" -> " foo "
          padding = 1,
          -- What markdown characters are used for the export, you probably
          -- don't want to change these
          characters = {
            horizontal = "-",
            vertical = "|",
            -- Filler for padding
            filler = " ",
          },
        },
      },
      set_mappings = function(buf)
        vim.api.nvim_buf_set_keymap(buf, "n", "<Left>", "<Cmd>JumpLeft<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Left>", "<Cmd>SwapWithLeftCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<Right>", "<Cmd>JumpRight<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Right>", "<Cmd>SwapWithRightCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<Up>", "<Cmd>JumpUp<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Up>", "<Cmd>SwapWithUpperCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<Down>", "<Cmd>JumpDown<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Down>", "<Cmd>SwapWithLowerCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<Tab>", "<Cmd>JumpToNextCell<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Tab>", "<Cmd>JumpToPreviousCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<C-Left>", "<Cmd>SwapWithLeftColumn<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<C-Right>", "<Cmd>SwapWithRightColumn<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<C-Up>", "<Cmd>SwapWithUpperRow<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<C-Down>", "<Cmd>SwapWithLowerRow<CR>", { silent = true })
      end,
    },
  },

  {
    "Kicamon/markdown-table-mode.nvim",
    config = true,
    ft = markdown_ft,
  },
  {
    "bngarren/checkmate.nvim",
    enabled = false,
    ft = markdown_ft, -- Lazy loads for Markdown files matching patterns in 'files'
    -- opts = {},
    config = true,
    opts = function()
      ---@diagnostic disable:missing-fields
      ---@module "checkmate"
      ---@type checkmate.Config
      local opts = {
        enabled = true,
        notify = true,
        files = { "*.md", "todo", "TODO", "*.todo*" }, -- matches TODO, TODO.md, .todo.md
        log = {
          level = "info",
          use_file = false,
          use_buffer = false,
        },
        -- Default keymappings
        keys = {
          ["<localleader>tt"] = "toggle", -- Toggle todo item
          ["<localleader>tc"] = "check", -- Set todo item as checked (done)
          ["<localleader>tu"] = "uncheck", -- Set todo item as unchecked (not done)
          ["<localleader>tn"] = "create", -- Create todo item
          ["<localleader>tR"] = "remove_all_metadata", -- Remove all metadata from a todo item
          ["<localleader>ta"] = "archive", -- Archive checked/completed todo items (move to bottom section)
        },
        default_list_marker = "-",
        todo_markers = {
          unchecked = "□",
          checked = "✔",
        },
        style = {},
        todo_action_depth = 1, --  Depth within a todo item's hierachy from which actions (e.g. toggle) will act on the parent todo item
        enter_insert_after_new = true, -- Should enter INSERT mode after :CheckmateCreate (new todo)
        smart_toggle = {
          enabled = true,
          check_down = "direct_children",
          uncheck_down = "none",
          check_up = "direct_children",
          uncheck_up = "direct_children",
        },
        show_todo_count = true,
        todo_count_position = "eol",
        todo_count_recursive = true,
        use_metadata_keymaps = true,
        -- metadata = {
        --   -- Example: A @priority tag that has dynamic color based on the priority value
        --   priority = {
        --     style = function(_value)
        --       local value = _value:lower()
        --       if value == "high" then
        --         return { fg = "#ff5555", bold = true }
        --       elseif value == "medium" then
        --         return { fg = "#ffb86c" }
        --       elseif value == "low" then
        --         return { fg = "#8be9fd" }
        --       else -- fallback
        --         return { fg = "#8be9fd" }
        --       end
        --     end,
        --     get_value = function()
        --       return "medium" -- Default priority
        --     end,
        --     key = "<localleader>tp",
        --     sort_order = 10,
        --     jump_to_on_insert = "value",
        --     select_on_insert = true,
        --   },
        --   -- Example: A @started tag that uses a default date/time string when added
        --   started = {
        --     aliases = { "init" },
        --     style = { fg = "#9fd6d5" },
        --     get_value = function() return tostring(os.date "%m/%d/%y %H:%M") end,
        --     key = "<localleader>ts",
        --     sort_order = 20,
        --   },
        --   -- Example: A @done tag that also sets the todo item state when it is added and removed
        --   done = {
        --     aliases = { "completed", "finished" },
        --     style = { fg = "#96de7a" },
        --     get_value = function() return tostring(os.date "%m/%d/%y %H:%M") end,
        --     key = "<localleader>td",
        --     on_add = function(todo_item) require("checkmate").set_todo_item(todo_item, "checked") end,
        --     on_remove = function(todo_item) require("checkmate").set_todo_item(todo_item, "unchecked") end,
        --     sort_order = 30,
        --   },
        -- },
        archive = {
          heading = {
            title = "Archive",
            level = 2, -- e.g. ##
          },
          parent_spacing = 0, -- no extra lines between archived todos
        },
        linter = {
          enabled = true,
        },
      }
      ---@diagnostic enable:missing-fields
      return opts
    end,
  },
}
