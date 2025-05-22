if vim.fn.has "win32" == 1 then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.tailwindcss" },
}
