vim.schedule(function()
  vim.lsp.config("nixd", {
    reuse_client = function(client, config) return client.name == config.name end,
    settings = {},
  })
end)
---@type LazySpec
return {
  { import = "astrocommunity.pack.nix" },
}
