---@type LazySpec
return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
  opts = function(_, opts)
    local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

    -- hl-groups can have any name
    vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

    local function text_format(symbol)
      local res = {}

      local round_start = { "", "SymbolUsageRounding" }
      local round_end = { "", "SymbolUsageRounding" }

      -- Indicator that shows if there are any other symbols in the same line
      local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

      if symbol.references then
        table.insert(res, round_start)
        table.insert(res, { "󰌹 ", "SymbolUsageRef" })
        table.insert(res, { tostring(symbol.references), "SymbolUsageContent" })
        table.insert(res, round_end)
      end

      if symbol.definition then
        if #res > 0 then table.insert(res, { " ", "NonText" }) end
        table.insert(res, round_start)
        table.insert(res, { "󰳽 ", "SymbolUsageDef" })
        table.insert(res, { tostring(symbol.definition), "SymbolUsageContent" })
        table.insert(res, round_end)
      end

      if symbol.implementation then
        if #res > 0 then table.insert(res, { " ", "NonText" }) end
        table.insert(res, round_start)
        table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
        table.insert(res, { tostring(symbol.implementation), "SymbolUsageContent" })
        table.insert(res, round_end)
      end

      if stacked_functions_content ~= "" then
        if #res > 0 then table.insert(res, { " ", "NonText" }) end
        table.insert(res, round_start)
        table.insert(res, { " ", "SymbolUsageImpl" })
        table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
        table.insert(res, round_end)
      end

      return res
    end

    ---@type UserOpts
    return {
      text_format = text_format,
      ---@type 'above'|'end_of_line'|'textwidth'|'signcolumn' `above` by default
      vt_position = "end_of_line",
      vt_priority = nil, ---@type integer Virtual text priority (see `nvim_buf_set_extmark`)
    }
  end,
}
