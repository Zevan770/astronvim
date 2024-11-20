if true then return {} end
if vim.fn.has "win" == 1 then return {} end

---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.nix" },
  },
}
