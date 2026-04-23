local servers = {
  "basedpyright",
  -- "ty",
  "bashls",
  -- "efm",
  -- "pyright",
  "clangd",
  -- "eslint",
  -- "html",
  -- "jdtls",
  -- "jsonls",
  -- "lemminx",
  -- "lua_ls",
  "emmylua_ls",
  "stylua",
  -- "marksman",
  -- "sqls",
  "taplo",
  -- "vimls",
  "volar",
  "vtsls",
  -- "nil_ls",
  -- "markdown_oxide",
  -- "zk",
}
vim.lsp.enable(servers)

---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append",
    },
  },
  { import = "os.module.disable-mason-auto-install" },
}
