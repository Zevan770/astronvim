---@diagnostic disable: missing-fields
---@type LazySpec
return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
  opts = function(_, opts)
    local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

    -- hl-groups can have any name
    vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Type").fg, bg = h("CursorLine").bg, bold = true })

    vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Function").fg, bg = h("CursorLine").bg, bold = true })

    vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@parameter").fg, bg = h("CursorLine").bg, bold = true })
    local function text_format(symbol)
      local res = {}

      -- Indicator that shows if there are any other symbols in the same line
      local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

      if symbol.references then table.insert(res, { " " .. tostring(symbol.references), "SymbolUsageRef" }) end

      if symbol.definition then
        if #res > 0 then table.insert(res, { " ", "NonText" }) end
        table.insert(res, { "󰳽 " .. tostring(symbol.definition), "SymbolUsageDef" })
      end

      if symbol.implementation then
        if #res > 0 then table.insert(res, { " ", "NonText" }) end
        table.insert(res, { tostring(symbol.implementation), "SymbolUsageContent" })
      end

      if stacked_functions_content ~= "" then
        if #res > 0 then table.insert(res, { " ", "NonText" }) end
        table.insert(res, { " " .. tostring(stacked_functions_content), "SymbolUsageImpl" })
      end

      return res
    end
    ---@module "symbol-usage"
    ---@type UserOpts
    return {
      text_format = text_format,
      ---@type 'above'|'end_of_line'|'textwidth'|'signcolumn' `above` by default
      vt_position = "end_of_line",
      vt_priority = nil, ---@type integer Virtual text priority (see `nvim_buf_set_extmark`)
      disable = { lsp = { "obsidian-ls" }, filetypes = { "markdown" } },
      filetypes = {
        -- markdown = {
        --   kinds = { SymbolKind.Variable },
        -- },
      },
    }
  end,
}
