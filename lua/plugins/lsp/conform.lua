-- if true then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.editing-support.conform-nvim" },
  {
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      -- opts.log_level = vim.log.levels.TRACE

      -- vim.notify(vim.inspect(opts), vim.log.levels.INFO, { title = "conform opts" })
      ---@param bufnr integer
      ---@param ... string
      ---@return string
      local function first(bufnr, ...)
        local conform = require "conform"
        for i = 1, select("#", ...) do
          local formatter = select(i, ...)
          if conform.get_formatter_info(formatter, bufnr).available then return formatter end
        end
        return select(1, ...)
      end
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.markdown = function(bufnr) return { first(bufnr, "prettierd", "prettier"), "injected" } end
      -- opts.formatters = {
      --   injected = {
      --     options = {},
      --   },
      -- }
      -- vim.notify(vim.inspect(opts), vim.log.levels.INFO, { title = "conform opts" })
      return opts
    end,
    -- opts = {
    --   log_level = vim.log.levels.DEBUG,
    --   formatters_by_ft = {
    --     ["*"] = { "injected" },
    --     html = { "prettier" },
    --     markdown = { "prettier" },
    --     lua = { "stylua" },
    --   },
    -- },
  },
}
