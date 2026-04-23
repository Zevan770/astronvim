vim.lsp.enable("lua_ls")
---@type LazySpec
return {
  { import = "os.module.disable-mason-auto-install" },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
      },
    },
  },
}
