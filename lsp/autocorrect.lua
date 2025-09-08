return {
  cmd = { "autocorrect", "server" },
  filetypes = {
    "markdown",
    "text",
    "org",
    "rst",
    "latex",
  },
  root_markers = { ".git", ".autocorrectrc", "autocorrect.toml" },
  single_file_support = true,
}
