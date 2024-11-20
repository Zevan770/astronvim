---@type LazySpec
return {
  {
    "folke/edgy.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>ts"] = {
                function()
                  require("edgy").toggle()
                end,
                desc = "Toggle Sidebars",
              },
              ["<Leader>aa"] = {
                function()
                  require("edgy").select()
                end,
                desc = "Pick Sidebar",
              },
            },
          },
        },
      },
    },
    opts = function()
      local opts = {}
      -- opts.exit_when_last = true
      opts.bottom = {
        { ft = "qf", title = "QuickFix" },
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "noice",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        "Trouble",
        { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
        { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
      }
      opts.left = {
        {
          title = "Files",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = "Neotree position=left filesystem",
          size = { height = 0.5 },
        },
        {
          title = "Git Status",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        {
          title = "Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
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
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
          title = "Help",
        },
        {
          title = "Symbol Outline",
          ft = "lspsaga",
          pinned = true,
          open = "Lspsaga outline",
        },
      }

      -- trouble
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
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
      -- -- increase width
      -- ["<C-Right>"] = function(win) win:resize("width", 2) end,
      -- -- decrease width
      -- ["<C-Left>"] = function(win) win:resize("width", -2) end,
      -- -- increase height
      -- ["<C-Up>"] = function(win) win:resize("height", 2) end,
      -- -- decrease height
      -- ["<C-Down>"] = function(win) win:resize("height", -2) end,
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
}
