-- if true then return {} end

---@type LazySpec
return {
  { import = "astrocommunity.editing-support.conform-nvim" },
  -- { "jay-babu/mason-null-ls.nvim", optional = true, opts = { methods = { formatting = false } } },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- opts.log_level = vim.log.levels.TRACE

      -- vim.notify(vim.inspect(opts), vim.log.levels.INFO, { title = "conform opts" })
      return require("astrocore").extend_tbl(
        opts,
        ---@module "conform"
        ---@type conform.setupOpts
        {
          formatters_by_ft = {
            markdown = function(_) return { "mdsf", lsp_format = "first" } end,
            nix = { "alejandra" },
            vue = { "prettier" },
          },
          formatters = {
            injected = { options = { ignore_errors = true } },
          },
          default_format_opts = { lsp_format = "fallback" },
          -- format_on_save = function(bufnr)
          --   if vim.F.if_nil(vim.b[bufnr].autoformat, vim.g.autoformat, true) then
          --     require("utils.format").format_git_hunks(bufnr)
          --   end
          -- end,
        }
      )
    end,
    keys = {
      {
        "<leader>lF",
        function() require("conform").format { formatters = { "injected" }, timeout_ms = 3000 } end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    config = function(self, opts)
      require("conform").setup(opts)
      -- HACK: we don't need this workaround for conform.nvim issue
      vim.api.nvim_del_autocmd(vim.api.nvim_get_autocmds({
        group = "Conform",
        event = "VimLeavePre",
      })[1].id)
    end,
  },
}
