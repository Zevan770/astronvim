---@diagnostic disable: missing-fields, inject-field

---@type vim.lsp.ClientConfig
return {
  cmd = { "node", "E:\\dev\\vscode-kanata\\out\\server.js", "--stdio" },
  filetypes = {
    "kanata",
  },
  root_markers = { "kanata.kbd", ".git" },
  single_file_support = true,
  init_options = {
    includesAndWorkspaces = "workspace",
    mainConfigFile = "kanata.kbd",
    localKeysVariant = "deflocalkeys-wintercept",
    format = {
      enable = true,
      useDefsrcLayoutOnDeflayers = true,
    },
    envVariables = {
      -- HACK: neovim json serializer treat empty lua table as json array, while vscode-kanata expect an object,
      -- resulting Error("invalid type: sequence, expected a map")
      dummy = "value",
    },
    dimInactiveConfigItems = false,
  },
}
