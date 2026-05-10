if true then return {} end
return {
  {
    "iwe-org/iwe.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      require("iwe").setup {
        lsp = {
          cmd = { "iwes" },
          auto_format_on_save = false,
          enable_inlay_hints = true,
          debounce_text_changes = 500,
        },
        mappings = {
          enable_markdown_mappings = true, -- Core markdown editing keybindings
          enable_picker_keybindings = false, -- Set to true to enable gf, gs, ga, g/, gb, gR, go
          enable_lsp_keybindings = true, -- Set to true to enable IWE-specific LSP keybindings
          enable_preview_keybindings = true, -- Set to true to enable preview keybindings
          leader = "<localleader>",
          localleader = "<localleader>",
        },
        telescope = {
          enabled = false,
          setup_config = false,
        },
        picker = {
          backend = "snacks", -- "auto", "telescope", "fzf_lua", "snacks", "mini", "vim_ui"
        },
        preview = {
          output_dir = vim.fn.stdpath "cache" .. "/markdown-iwe-preview",
          temp_dir = "/tmp",
          auto_open = false,
        },
      }
    end,
  },
}
