if true then return {} end
---@type LazySpec
return {
  {
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    opts = {
      position = "right",
    },
  },
}
