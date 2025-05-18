return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  cond = not my_utils.is_neovide and not my_utils.is_firenvim and not vim.env.KITTY_PID and not my_utils.is_vscode,
  -- enabled = false,
  -- see ~/.local/share/nvim/lazy/smear-cursor.nvim/lua/smear_cursor/config.lua
  opts = {
    hide_target_hack = true,
    cursor_color = "none",
    legacy_computing_symbols_support = true,
    min_horizontal_distance_smear = 8,
    min_vertical_distance_smear = 3,
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
}
