-- if true then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.editing-support.conform-nvim" },
  -- { "jay-babu/mason-null-ls.nvim", optional = true, opts = { methods = { formatting = false } } },
  {
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@return conform.setupOpts
    opts = function(_, opts)
      -- opts.log_level = vim.log.levels.TRACE

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

      -- vim.notify(vim.inspect(opts), vim.log.levels.INFO, { title = "conform opts" })
      return require("astrocore").extend_tbl(opts, {
        formatters_by_ft = {
          markdown = function(bufnr) return { first(bufnr, "prettierd", "prettier"), "injected" } end,
        },
        formatters = {
          injected = { options = { ignore_errors = true } },
        },
      })
    end,
    keys = {
      {
        "<leader>lF",
        function() require("conform").format { formatters = { "injected" }, timeout_ms = 3000 } end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
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
