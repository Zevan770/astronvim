local M = {}

---@param modes any
---@param maps AstroCoreMappings
---@param group string
---@param new_group string
M.replace_group = function(modes, maps, group, new_group)
  if type(modes) == "string" then modes = { modes } end
  for _, mode in ipairs(modes) do
    for k, v in pairs(maps[mode]) do
      if k:find(group) then
        if new_group then maps[mode][k:gsub(group, new_group)] = v end
        maps[mode][k] = false
      end
    end
  end
end

-- M.smart_definition = function ()
--   if not require("astrocore").is_available("lspsaga") then
--     require("lspsaga.definition").definition_request
--   else if not vim.lsp.buf.definition() then
--
--   end
-- end
return M
