if true then return {} end
---@type LazySpec
return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local palette = vim.o.background == "light" and require "catppuccin.palettes.latte"
        or require "catppuccin.palettes.mocha"
      local excluded_ft = {
        ["neo-tree"] = true,
        snacks_dashboard = true,
        fidget = true,
        help = true,
        snacks_picker_preview = true,
      }

      local indent_colors = {
        palette.surface0,
        palette.surface1,
        palette.surface2,
        palette.overlay0,
        palette.overlay1,
        palette.overlay2,
        palette.subtext0,
        palette.subtext1,
        palette.text,
      }
      return {
        chunk = {
          delay = 100,
          enable = true,
          exclude_filetypes = excluded_ft,
          style = palette.lavender,
        },
        indent = {
          enable = true,
          exclude_filetypes = excluded_ft,
          style = indent_colors,
        },
      }
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },
}
