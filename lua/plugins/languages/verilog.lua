if my_utils.is_windows or my_utils.is_android then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.verilog" },
    -- { import = "astrocommunity.lsp.nvim-java" },
  },
}
