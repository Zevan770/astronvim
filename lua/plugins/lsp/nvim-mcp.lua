return {
  {
    "linw1995/nvim-mcp",
    enabled = my_utils.is_nixos,
    build = "cargo install --path .",
    opts = {},
  },
}
