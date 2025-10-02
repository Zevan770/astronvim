if true then return {} end
---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", lazy = true, opts = {} },
    },
    cmd = function(_, cmds) -- HACK: lazy load lspconfig on `:Neoconf` if neoconf is available
      if require("lazy.core.config").spec.plugins["neoconf.nvim"] then table.insert(cmds, "Neoconf") end
      vim.list_extend(cmds, { "LspInfo", "LspLog", "LspStart" }) -- add normal `nvim-lspconfig` commands
    end,
  },
  {
    "folke/neoconf.nvim",
    ---@module "neoconf"
    ---@type Config
    opts = {
      live_reload = true,
      plugins = {
        lua_ls = {
          -- by default, lua_ls annotations are only enabled in your neovim config directory
          enabled_for_neovim_config = true,
          -- explicitly enable adding annotations. Mostly relevant to put in your local .neoconf.json file
          enabled = true,
        },
      },
    },
  },
}
