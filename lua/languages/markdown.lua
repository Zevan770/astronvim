vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function() vim.opt_local.wrap = true end,
  pattern = { "*.md", "*.txt" },
})

return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  -- { import = "astrocommunity.note-taking.obsidian-nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = { file_types = { "markdown", "Avante" } },
  },
}
