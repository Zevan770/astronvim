---@diagnostic disable: missing-fields, inject-field

---@type vim.lsp.ClientConfig
return {
  cmd = { "rumdl", "server" },
  filetypes = { "markdown", "mdx" },
  single_file_support = true,
  root_markers = {
    ".git",
    ".rumdl.toml",
  },
}
