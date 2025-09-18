return {
  {
    "tamton-aquib/flirt.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      override_open = true,
      default_move_mappings = true,
      default_resize_mappings = true,
      default_mouse_mappings = true,
      exclude_fts = { "notify", "cmp_menu", "which-key" },
      speed = 95,
      custom_filter = function(buffer, win_config) return vim.bo[buffer].filetype == "cmp_menu" end,
    },
  },
}
