local M = {}

M.navic = function()
  return {
    condition = function() return require("nvim-navic").is_available() end,
    provider = function() return require("nvim-navic").get_location { highlight = true } end,
    update = "CursorMoved",
  }
end

return M
