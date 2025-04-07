if utils.is_windows or utils.is_android then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.verilog" },
    -- { import = "astrocommunity.lsp.nvim-java" },
  },
}
