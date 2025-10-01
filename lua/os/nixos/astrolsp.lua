-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append",
    },
  },
  { import = "os.module.disable-mason-auto-install" },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = {
        "basedpyright",
        "bashls",
        -- "efm",
        -- "pyright",
        "clangd",
        -- "eslint",
        -- "html",
        -- "jdtls",
        -- "jsonls",
        -- "lemminx",
        "lua_ls",
        -- "marksman",
        -- "sqls",
        "taplo",
        -- "vimls",
        "volar",
        "vtsls",
        -- "nil_ls",
        -- "markdown_oxide",
        -- "zk",
        "ruff",
      },
      ---@diagnostic disable: missing-fields
      config = {},
    },
  },
}
