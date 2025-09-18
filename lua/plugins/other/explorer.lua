---@type LazySpec
return {
  {
    "mikavilpas/yazi.nvim",
    cmd = {
      "Yazi",
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>oe",
        function() require("yazi").yazi() end,
        desc = "Reveal cur file in yazi",
      },
      {
        -- Open in the current working directory
        "<leader>oy",
        function() require("yazi").yazi(nil, vim.fn.getcwd()) end,
        desc = "Open yazi pwd",
      },
      {
        "<A-y>",
        function()
          -- NOTE: requires a version of yazi that includes
          -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
          require("yazi").toggle()
        end,
        desc = "Resume the last yazi session",
        mode = { "n", "v", "i" }, --all
      },
      {
        "<A-y>",
        "<Cmd>wincmd q<CR>",
        mode = { "t" },
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      open_multiple_tabs = true,

      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-s>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-g>",
        replace_in_directory = "<c-r>",
        cycle_open_buffers = "<c-n>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
        change_working_directory = "<c-\\>",
      },
      -- enable these if you are using the latest version of yazi
      use_ya_for_events_reading = true,
      use_yazi_client_id_flag = true,
      clipboard_register = "+",
      enable_mouse_support = true,
      -- yazi_floating_window_winblend = 5,
      integrations = {
        grep_in_directory = "snacks.picker",
      },
    },

    specs = {
      {
        "neo-tree.nvim",
        optional = true,
        opts = {
          filesystem = {
            hijack_netrw_behavior = "disabled",
          },
        },
      },
    },
  },

  { import = "astrocommunity.file-explorer.oil-nvim" },
  {
    "stevearc/oil.nvim",
    opts = {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
      default_file_explorer = true,
      delete_to_trash = true,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<C-l>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["gr"] = "actions.refresh",
        ["<C-h>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            vim.b.oil_detail = not vim.b.oil_detail
            local detail = vim.b.oil_detail
            if detail then
              require("oil").set_columns { "icon", "permissions", "size", "mtime" }
            else
              require("oil").set_columns { "icon" }
            end
          end,
        },
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "auto",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf) return conf end,
      },
      -- Configuration for the actions floating preview window
      preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
      },
    },
  },

  { import = "astrocommunity.file-explorer.mini-files" },
  {
    "echasnovski/mini.files",
    opts = {
      mappings = {
        synchronize = "<c-s>",
      },
      windows = {
        preview = true,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 75,
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>e"] = {
                function()
                  if not require("mini.files").close() then
                    require("mini.files").open(MiniFiles.get_latest_path(), true)
                  end
                end,
                desc = "Explorer",
              },
              ["<Leader>ob"] = {
                function()
                  if not require("mini.files").close() then
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
                  end
                end,
                desc = "Explorer",
              },
            },
          },
        },
      },
    },
  },

  {
    "chrisgrieser/nvim-genghis",
    init = function()
      -- vim.g.whichkeyAddSpec { "<leader>F", group = "󰈔 File" }
      -- vim.g.whichkeyAddSpec { "<leader>y", group = "󰅍 Yank" }
    end,
    keys = {
		  -- stylua: ignore start
		  {"<leader>ya", function() require("genghis").copyFilepathWithTilde() end, desc = "󰝰 Absolute path" },
		  {"<leader>yr", function() require("genghis").copyRelativePath() end, desc = "󰝰 Relative path" },
		  {"<leader>yn", function() require("genghis").copyFilename() end, desc = "󰈔 Name of file" },
		  {"<leader>yp", function() require("genghis").copyDirectoryPath() end, desc = "󰝰 Parent path" },
		  {"<leader>yf", function() require("genghis").copyFileItself() end, desc = "󱉥 File (macOS)" },
      -- stylua: ignore end

      { "<leader>Fr", function() require("genghis").renameFile() end, desc = "󰑕 Rename" },
      { "<leader>Fn", function() require("genghis").createNewFile() end, desc = "󰝒 New" },
      { "<leader>Fw", function() require("genghis").duplicateFile() end, desc = " Duplicate" },
      { "<leader>Fm", function() require("genghis").moveToFolderInCwd() end, desc = "󱀱 Move" },
      { "<leader>Fd", function() require("genghis").trashFile() end, desc = "󰩹 Delete" },
      { "<leader>Fx", function() require("genghis").chmodx() end, desc = "󰒃 chmod +x" },

      -- -- stylua: ignore
      -- { "<M-CR>", function() require("genghis").navigateToFileInFolder("next") end, desc = "󰖽 Next file in folder" },
      -- -- stylua: ignore
      -- { "<S-M-CR>", function() require("genghis").navigateToFileInFolder("prev") end, desc = "󰖿 Prev file in folder" },

      {
        "<leader>rx",
        function() require("genghis").moveSelectionToNewFile() end,
        mode = "x",
        desc = "󰝒 Selection to new file",
      },
      -- stylua: ignore
      -- { "<D-l>", function() require("genghis").showInSystemExplorer() end, desc = "󰀶 Reveal in Finder" },
    },
  },
}
