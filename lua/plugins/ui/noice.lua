-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  -- { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(
        opts,
        ---@module "noice"
        ---@type NoiceConfig
        {
          lsp = {
            -- progress = {
            --   enabled = false,
            -- },
            hover = { enabled = false },
            signature = { enabled = false },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
              ["vim.lsp.util.stylize_markdown"] = false,
              -- ["cmp.entry.get_documentation"] = true,
            },
          },
          -- notify = {
          --   enabled = false,
          -- },
          presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
          },
        }
      )
    end,
    keys = {
      { "<leader>onl", function() require("noice").cmd "last" end, desc = "Noice Last Message" },
      { "<leader>onh", function() require("noice").cmd "history" end, desc = "Noice History" },
      { "<leader>ona", function() require("noice").cmd "all" end, desc = "Noice All" },
      { "<leader>ond", function() require("noice").cmd "dismiss" end, desc = "Dismiss All" },
      { "<leader>onf", function() require("noice").cmd "pick" end, desc = "Noice Picker" },
    },
    specs = {
      {
        "AstroNvim/astrolsp",
        optional = true,
        ---@param opts AstroLSPOpts
        opts = function(_, opts)
          local noice_opts = require("astrocore").plugin_opts "noice.nvim"
          -- disable the necessary handlers in AstroLSP
          if not opts.lsp_handlers then opts.lsp_handlers = {} end
          if vim.tbl_get(noice_opts, "lsp", "hover", "enabled") ~= false then
            opts.lsp_handlers["textDocument/hover"] = false
          end
          if vim.tbl_get(noice_opts, "lsp", "signature", "enabled") ~= false then
            opts.lsp_handlers["textDocument/signatureHelp"] = false
            if not opts.features then opts.features = {} end
            opts.features.signature_help = false
          end
        end,
      },
      {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          if not opts.bottom then opts.bottom = {} end
          table.insert(opts.bottom, {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
          })
        end,
      },
    },
  },
}
