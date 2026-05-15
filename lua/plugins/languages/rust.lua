if not my_utils.is_nixos then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.pack.rust" },
}
