if vim.fn.has "win32" == 1 then return {} end

---@type LazySpec
return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    keys = ",nn",
    version = "*",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "saghen/blink.cmp",
        optional = true,
        dependencies = { "saghen/blink.compat" },
        opts = {
          sources = {
            default = { "neorg" },
            providers = {
              neorg = {
                name = "neorg",
                module = "blink.compat.source",
              },
            },
          },
        },
      },
    },
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.keybinds"] = {}, -- Adds default keybindings
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
            name = "neorg",
          },
        }, -- Enables support for completion plugins
        ["core.journal"] = {}, -- Enables support for the journal module
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/neorg",
            },
            -- default_workspace = "neorg",
          },
        },
      },
    },
  },
}
