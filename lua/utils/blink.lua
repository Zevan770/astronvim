local M = {}

M.get_trigger_characters = function(self)
  local trigger_characters
  if not self or type(self.get_trigger_characters) ~= "function" then
    trigger_characters = {}
  else
    trigger_characters = self:get_trigger_characters()
  end

  vim.list_extend(trigger_characters, { "\n", "\t", " " })
  return trigger_characters
end

return M
