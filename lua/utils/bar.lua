local M = {}

M.navic = function()
  return {
    condition = function() return require("nvim-navic").is_available() end,
    provider = function() return require("nvim-navic").get_location { highlight = true } end,
    update = "CursorMoved",
  }
end

-- {
-- 	file = {
-- 		definitions = 1,
-- 		references = 4,
-- 	},
-- 	workspace = {
-- 		definitions = 2,
-- 		references = 10,
M.lsp_def_ref = function()
  return {
    provider = function()
      local lspCountTable = require("dr-lsp").lspCountTable()
      if not lspCountTable then return "" end

      local sb = {}

      -- 引用部分
      if lspCountTable.file and lspCountTable.file.references then
        table.insert(sb, " " .. tostring(lspCountTable.file.references))

        if lspCountTable.workspace and lspCountTable.workspace.references then
          table.insert(sb, "(" .. tostring(lspCountTable.workspace.references) .. ")")
        end
      end

      -- 定义部分
      if lspCountTable.file and lspCountTable.file.definitions then
        if #sb > 0 then table.insert(sb, " ") end
        table.insert(sb, "󰳽 " .. tostring(lspCountTable.file.definitions))

        if lspCountTable.workspace and lspCountTable.workspace.definitions then
          table.insert(sb, "(" .. tostring(lspCountTable.workspace.definitions) .. ")")
        end
      end

      local res = table.concat(sb)

      return res
    end,
    update = "CursorHold",
    padding = { left = 1 },
    hl = "SymbolUsageRef",
  }
end
return M
