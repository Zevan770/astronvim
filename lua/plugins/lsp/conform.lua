-- if true then return {} end
local format_git_hunks = function(bufnr)
  bufnr = bufnr or 0
  local ignore_filetypes = { "lua", "python" }
  local format = require("conform").format
  if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
    format { lsp_fallback = true, timeout_ms = 500 }
    return
  end

  local hunks = require("gitsigns").get_hunks(bufnr)
  if hunks == nil then return end

  local function format_range()
    if next(hunks) == nil then
      vim.notify("done formatting git hunks", "info", { title = "formatting" })
      return
    end
    local hunk = nil
    while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
      hunk = table.remove(hunks)
    end

    if hunk ~= nil and hunk.type ~= "delete" then
      local start = hunk.added.start
      local last = start + hunk.added.count
      -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
      local last_hunk_line = vim.api.nvim_buf_get_lines(bufnr, last - 2, last - 1, true)[1]
      local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
      format({ range = range, lsp_fallback = true, timeout_ms = 1000 }, function()
        vim.defer_fn(function() format_range() end, 1)
      end)
    end
  end

  format_range()
end

---@type LazySpec
return {
  { import = "astrocommunity.editing-support.conform-nvim" },
  -- { "jay-babu/mason-null-ls.nvim", optional = true, opts = { methods = { formatting = false } } },
  {
    "stevearc/conform.nvim",
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
      return require("astrocore").extend_tbl(
        opts,
        ---@module "conform"
        ---@type conform.setupOpts
        {
          formatters_by_ft = {
            markdown = function(_) return { "prettier", "injected" } end,
            yaml = { "prettier" },
            nix = { "alejandra" },
          },
          formatters = {
            injected = { options = { ignore_errors = true } },
          },
          default_format_opts = { lsp_format = "fallback" },
          format_on_save = function(bufnr)
            if vim.F.if_nil(vim.b[bufnr].autoformat, vim.g.autoformat, true) then format_git_hunks(bufnr) end
          end,
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
  },
}
