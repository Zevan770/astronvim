if not my_utils.is_windows then return {} end

return {
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "file:C:/Users/86135/ghq/github.com/mason-org/mason-registry",
      },
    },
  },
}
