return {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
    textDocument = {
      semanticTokens = {
        enabled = false,
      },
    },
  },
}
