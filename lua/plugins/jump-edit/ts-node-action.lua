if true then return {} end
---@type LazySpec
return {
  "CKolkey/ts-node-action",
  config = true,
  lazy = true,
  event = "User AstroFile",
  specs = {
    "none-ls.nvim",
    optional = true,
    opts = {
      sources = {
        require("null-ls").builtins.code_actions.ts_node_action,
      },
    },
  },
}
