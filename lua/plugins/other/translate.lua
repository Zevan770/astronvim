---@type LazySpec
return {
  {
    "potamides/pantran.nvim",
    cmd = {
      "Pantran",
    },
    opts = {
      -- Default engine to use for translation. To list valid engine names run
      -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
      default_engine = "google",
      -- Configuration for individual engines goes here.
      engines = {
        google = {
          -- Default languages can be defined on a per engine basis. In this case
          -- `:lua require("pantran.async").run(function() vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
          -- can be used to list available language identifiers.
          default_source = "auto",
          default_target = "zh-CN",
        },
      },
      controls = {
        mappings = {
          edit = {
            n = {
              -- Use this table to add additional mappings for the normal mode in
              -- the translation window. Either strings or function references are
              -- supported.
              ["j"] = "gj",
              ["k"] = "gk",
            },
            i = {
              -- Similar table but for insert mode. Using 'false' disables
              -- existing keybindings.
              ["<C-y>"] = false,
              ["<C-a>"] = function() require("pantran.ui.actions").yank_close_translation() end,
            },
          },
          -- Keybindings here are used in the selection window.
          select = {
            n = {
              -- ...
            },
          },
        },
      },
    },
  },
}
