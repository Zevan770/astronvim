vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function() vim.opt.wrap = true end,
  pattern = { "*.md", "*.txt" },
})

return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  specs = {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
  },
}
