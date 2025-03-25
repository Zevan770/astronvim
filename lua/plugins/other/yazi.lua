---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  cmd = {
    "Yazi",
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>ae",
      function() require("yazi").yazi() end,
      desc = "Reveal cur file in yazi",
    },
    {
      -- Open in the current working directory
      "<leader>ay",
      function() require("yazi").yazi(nil, vim.fn.getcwd()) end,
      desc = "Open yazi pwd",
    },
    {
      "<A-e>",
      function()
        -- NOTE: requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        require("yazi").toggle()
      end,
      desc = "Resume the last yazi session",
      mode = { "n", "v", "i" }, --all
    },
    {
      "<A-e>",
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
      cycle_open_buffers = "<tab>",
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
}
