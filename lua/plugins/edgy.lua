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
              ["<Leader>ts"] = { function() require("edgy").toggle() end, desc = "Toggle Sidebars" },
              ["<Leader>aa"] = { function() require("edgy").select() end, desc = "Pick Sidebar" },
            },
          },
        },
      },
    },
    opts = function(_, opts)
      table.insert(opts, {
        exit_when_last = true,
        bottom = {
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 20 },
            -- don't open help files in edgy that we're editing
            filter = function(buf) return vim.bo[buf].buftype == "help" end,
            title = "Help",
          },
        },
        -- left = {
        --   {
        --     title = "Files",
        --     ft = "neo-tree",
        --     filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
        --     pinned = true,
        --     open = "Neotree position=left filesystem",
        --     size = { height = 0.5 },
        --   },
        --   {
        --     title = "Git Status",
        --     ft = "neo-tree",
        --     filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
        --     pinned = true,
        --     open = "Neotree position=right git_status",
        --   },
        --   {
        --     title = "Buffers",
        --     ft = "neo-tree",
        --     filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
        --     pinned = true,
        --     open = "Neotree position=top buffers",
        --   },
        --   "neo-tree",
        -- },
        right = {
          -- {
          --   ft = "aerial",
          --   title = "Symbol Outline",
          --   pinned = true,
          --   open = function() require("aerial").open() end,
          -- },
          {
            title = "Symbol Outline",
            ft = "lspsaga",
            pinned = true,
            open = "Lspsaga outline",
          },
        },
        keys = {
          -- increase width
          ["<C-Right>"] = function(win) win:resize("width", 2) end,
          -- decrease width
          ["<C-Left>"] = function(win) win:resize("width", -2) end,
          -- increase height
          ["<C-Up>"] = function(win) win:resize("height", 2) end,
          -- decrease height
          ["<C-Down>"] = function(win) win:resize("height", -2) end,
        },
      })
    end,
  },
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
}
