-- if true then return {} end
--- @type LazySpec
return {
  -- { import = "astrocommunity.editing-support.yanky-nvim" },
  {
    "svban/YankAssassin.nvim", -- Don't let the cursor move while Yanking in Neovim
    event = "VeryLazy",
    config = function()
      require("YankAssassin").setup {
        auto_normal = true,
        auto_visual = true,
      }
      -- -- Optional Mappings
      -- vim.keymap.set({ "x", "n" }, "gy", "<Plug>(YADefault)", { silent = true })
      -- vim.keymap.set({ "x", "n" }, "<leader>y", "<Plug>(YANoMove)", { silent = true })
    end,
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10, -- Needs to be a really low priority, to catch others plugins keybindings.
    opts = {
      support = {
        substitute = {
          enabled = true,
        },
      },
      -- your configuration
    },
  },
}
