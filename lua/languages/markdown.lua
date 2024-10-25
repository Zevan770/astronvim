vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function() vim.opt_local.wrap = true end,
  pattern = { "*.md", "*.txt" },
})

return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.note-taking.obsidian-nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = { file_types = { "markdown", "Avante" } },
  },
  {
    "epwalsh/obsidian.nvim",
    event = {
      "BufReadPre  */notes/*.md",
    },
    config = {
      ui = { enabled = false },
      dir = vim.fn.has "win32" == 1 and "E:/desktop/大三上/notes" or "/mnt/e/desktop/大三上/notes",
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },
    },
  },
}
