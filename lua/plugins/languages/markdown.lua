-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   callback = function() vim.opt_local.wrap = true end,
--   pattern = { "*.md", "*.txt" },
-- })

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  -- { import = "astrocommunity.note-taking.obsidian-nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = { file_types = { "markdown", "Avante", "copilot-chat", "codecompanion" } },
    dependencies = {
      "nvim-cmp",
      opts = function(_, opts)
        local cmp = require "cmp"
        cmp.setup {
          sources = cmp.config.sources {
            { name = "render-markdown" },
          },
        }
      end,
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        my_ft_markdown = {
          {
            event = "Filetype",
            pattern = "markdown",
            callback = function() vim.opt_local.wrap = true end,
          },
        },
      },
    },
  },
}
