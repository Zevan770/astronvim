if not os.getenv("NIX_PATH") then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return { 
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append"
    }
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = {
        "pyright",
        "clangd",
        "eslint",
        "html",
        "jdtls",
        "jsonls",
        "lemminx",
        "lua_ls",
        "marksman",
        "sqls",
        "taplo",
        "vimls",
        "vtsls",
        "vuels"
      },
    }
  }
}

