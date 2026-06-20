return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      for k, v in pairs(vim.lsp.config._configs) do
        if v.reuse_client == nil then
          v.reuse_client = function(client, config) return client.name == config.name end
        end
      end
    end,
  },
}
