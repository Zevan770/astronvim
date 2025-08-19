local markdown_ft = {
  "markdown",
  "Avante",
  "quarto",
  "rmd",
  "html",
  "copilot-chat",
  "codecompanion",
  "blink-cmp-documentation",
  "blink-cmp-signature",
}
local render_md_on_ft = require("astrocore").list_insert_unique(markdown_ft, {})
local markview_on_ft = require("astrocore").list_insert_unique(markdown_ft, { "html", "yaml" })
---@type LazySpec
return {

  -- { import = "astrocommunity.pack.markdown" },

  -- #region render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = my_utils.markdown_render == "render",
    ft = render_md_on_ft,
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
      preset = "obsidian",
      completions = { lsp = { enabled = true } },
      injections = {
        -- Out of the box language injections for known filetypes that allow markdown to be interpreted
        -- in specified locations, see :h treesitter-language-injections.
        -- Set enabled to false in order to disable.
        gitcommit = {
          enabled = true,
          query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
        },
      },
      file_types = render_md_on_ft,
      indent = {
        enabled = true,
      },
      code = {
        border = "thin",
      },
    },
  },
  -- #endregion

  {
    "OXY2DEV/markview.nvim",
    priority = 1001,
    lazy = false,
    enabled = my_utils.markdown_render == "markview",
    opts = function()
      local presets = require "markview.presets"

      ---@type markdown.headings
      local headings = vim.deepcopy(presets.headings.arrowed)
      headings.org_indent = true

      ---@module "markview"
      ---@type markview.config
      return {
        preview = {
          map_gx = false,
          modes = { "n", "no", "c", "i" },
          hybrid_modes = { "n", "i" },
          enable_hybrid_mode = true,
          linewise_hybrid_mode = true,
          debounce = 50,
          -- edit_range = { 2, 2 },

          icon_provider = "mini",
          filetypes = markview_on_ft,
          ignore_buftypes = {},
          condition = function(buffer)
            return true
            -- local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt
            --
            -- if bt == "nofile" and ft == "codecompanion" then
            --   return true
            -- elseif bt == "nofile" then
            --   return false
            -- else
            --   return true
            -- end
          end,
        },
        ---@diagnostic disable
        markdown = {
          headings = headings,
          -- list_items = {
          --   shift_width = function(buffer, item)
          --     --- Reduces the `indent` by 1 level.
          --     ---
          --     ---         indent                      1
          --     --- ------------------------- = 1 ÷ --------- = new_indent
          --     --- indent * (1 / new_indent)       new_indent
          --     ---
          --     local parent_indnet = math.max(1, item.indent - vim.bo[buffer].shiftwidth)
          --
          --     return item.indent * (1 / (parent_indnet * 2))
          --   end,
          --   marker_minus = {
          --     add_padding = function(_, item) return item.indent > 1 end,
          --   },
          -- },
          -- code_blocks = {
          --   label_direction = "left",
          --   style = "simple",
          --   -- style = "block",
          -- },
        },
        yaml = {
          enable = false,
        },
        experimental = {
          -- linewise_ignore_org_indent = true,
          check_rtp = false,
        },
        ---@diagnostic enable
      }
    end,
    config = function(_, opts)
      require("markview").setup(opts)
      require("utils.lsp_hover").setup {}
      require("markview.extras.editor").setup()
      -- require("markview.extras.headings").setup()
      require("markview.extras.checkboxes").setup()
    end,
  },

  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
  },

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

  {
    {
      "Dan7h3x/LazyDo",
      branch = "main",
      cmd = { "LazyDoToggle", "LazyDoPin", "LazyDoToggleStorage" },
      keys = { -- recommended keymap for easy toggle LazyDo in normal and insert modes (arbitrary)
        { "<leader>ot", "<CMD>LazyDoToggle<CR>", mode = { "n" } },
      },
      opts = {
        -- your config here
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
      vim.g.mkdp_filetypes = markdown_ft
      -- vim.g.mkdp_browser = vim.env.BROWSER .. ""
      -- vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_combine_preview = 1
    end,
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Markdown = "" } } },
      {
        "AstroNvim/astrocore",
        optional = true,
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>M"

          maps.n[prefix] = { desc = require("astroui").get_icon("Markdown", 1, true) .. "Markdown" }
          maps.n[prefix .. "p"] = { "<cmd>MarkdownPreview<cr>", desc = "Preview" }
          maps.n[prefix .. "s"] = { "<cmd>MarkdownPreviewStop<cr>", desc = "Stop preview" }
          maps.n[prefix .. "t"] = { "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle preview" }
        end,
      },
    },
  },
}
