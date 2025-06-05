return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    cond = not my_utils.is_neovide and not my_utils.is_firenvim and not vim.env.KITTY_PID and not my_utils.is_vscode,
    -- enabled = false,
    -- see ~/.local/share/nvim/lazy/smear-cursor.nvim/lua/smear_cursor/config.lua
    opts = {
      hide_target_hack = true,
      cursor_color = "none",
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.4      [0, 1]
      stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
      -- legacy_computing_symbols_support = true,
      -- smear_horizontally = true,
      -- smear_vertically = true,
      -- min_horizontal_distance_smear = 8,
      -- min_vertical_distance_smear = 3,
      -- smear_between_neighbor_lines = false,
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
