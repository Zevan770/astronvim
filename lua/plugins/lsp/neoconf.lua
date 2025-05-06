---@type LazySpec
return {
  {
    "folke/neoconf.nvim",
    lazy = true,
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
