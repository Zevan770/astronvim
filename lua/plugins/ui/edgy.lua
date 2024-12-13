---@type LazySpec
return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    -- opts = function(_, opts)
    --   opts.ignored_filetypes = {}
    --   opts.ignored_buftypes = {}
    --   return opts
    -- end,
    keys = {
      {
        "<A-h>",
        function() require("smart-splits").move_cursor_left() end,
        desc = "Move to left split",
        mode = { "n", "i", "v", "t" },
      },
      {
        "<A-j>",
        function() require("smart-splits").move_cursor_down() end,
        desc = "Move to below split",
        mode = { "n", "i", "v", "t" },
      },
      {
        "<A-k>",
        function() require("smart-splits").move_cursor_up() end,
        desc = "Move to above split",
        mode = { "n", "i", "v", "t" },
      },
      {
        "<A-l>",
        function() require("smart-splits").move_cursor_right() end,
        desc = "Move to right split",
        mode = { "n", "i", "v", "t" },
      },
      {
        "<A-S-k>",
        function() require("smart-splits").resize_up() end,
        desc = "Resize split up",
        mode = { "n", "i", "v", "t" },
      },
      {
        "<A-S-j>",
        function() require("smart-splits").resize_down() end,
        desc = "Resize split down",
        mode = { "n", "i", "v", "t" },
      },
      {
        "<A-S-h>",
        function() require("smart-splits").resize_left() end,
        desc = "Resize split left",
        mode = { "n", "i", "v", "t" },
      },
      {
        "<A-S-l>",
        function() require("smart-splits").resize_right() end,
        desc = "Resize split right",
        mode = { "n", "i", "v", "t" },
      },
    },
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>ts"] = {
                function() require("edgy").toggle() end,
                desc = "Toggle Sidebars",
              },
              ["<Leader>aa"] = {
                function() require("edgy").select() end,
                desc = "Pick Sidebar",
              },
            },
          },
        },
      },
    },
    opts = function(_, opts)
      opts = opts or {}
      opts.exit_when_last = true
      opts.bottom = {
        { ft = "qf", title = "QuickFix" },
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
        },
        {
          ft = "noice",
          size = { height = 0.4 },
          filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
        },
        "Trouble",
        { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
        { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
      }
      opts.left = {
        {
          title = "Files",
          ft = "neo-tree",
          filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
          open = "Neotree position=left filesystem",
          size = { height = 0.5 },
        },
        {
          title = "Git Status",
          ft = "neo-tree",
          filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
          open = "Neotree position=right git_status",
        },
        {
          title = "Buffers",
          ft = "neo-tree",
          filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
          open = "Neotree position=top buffers",
        },
        "neo-tree",
      }
      opts.right = {
        -- {
        --   ft = "aerial",
        --   title = "Symbol Outline",
        --   pinned = true,
        --   open = function() require("aerial").open() end,
        -- },
        { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
        {
          ft = "help",
          -- don't open help files in edgy that we're editing
          filter = function(buf) return vim.bo[buf].buftype == "help" end,
          title = "Help",
          size = { width = 0.5 },
        },
        {
          title = "Symbol Outline",
          ft = "lspsaga",
          open = "Lspsaga outline",
        },
      }

      -- trouble
      for _, pos in ipairs { "top", "bottom", "left", "right" } do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_buf, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
      return opts
    end,
    keys = {
      -- close window
      ["q"] = function(win) win:close() end,
      -- hide window
      ["<c-q>"] = function(win) win:hide() end,
      -- close sidebar
      ["Q"] = function(win) win.view.edgebar:close() end,
      -- increase width
      ["<A-S-l>"] = function(win) win:resize("width", 2) end,
      -- decrease width
      ["<A-S-h>"] = function(win) win:resize("width", -2) end,
      -- increase height
      ["<A-S-k>"] = function(win) win:resize("height", 2) end,
      -- decrease height
      ["<A-S-j>"] = function(win) win:resize("height", -2) end,
      -- reset all custom sizing
      ["<c-w>="] = function(win) win.view.edgebar:equalize() end,
    },
    specs = {
      {
        "nvim-neo-tree/neo-tree.nvim",
        optional = true,
        opts = {
          source_selector = {
            winbar = false,
            statusline = false,
          },
        },
      },
    },
  },
  -- prevent neo-tree from opening files in edgy windows
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
        or { "terminal", "Trouble", "qf", "Outline", "trouble" }
      table.insert(opts.open_files_do_not_replace_types, "edgy")
    end,
  },
}
