return {
  cmd = { "autocorrect", "server" },
  -- HACK: 强制使用脚本去掉第一行的启动消息, https://github.com/huacnlee/autocorrect/issues/287
  -- cmd = { vim.fn.stdpath "config" .. "/lsp/autocorrect-lsp" },
  filetypes = {
    "markdown",
    "text",
    "org",
    "rst",
    "latex",
  },
  -- root_markers = { ".git", ".autocorrectrc", "autocorrect.toml" },
  single_file_support = true,
}
