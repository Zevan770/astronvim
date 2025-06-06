if true then return {} end
---@type LazySpec
return {
  "ray-x/navigator.lua",
  event = "User AstroFile",
  dependencies = { { "ray-x/guihua.lua", build = "cd lua/fzy && make" } },
  config = function()
    require("navigator").setup {
      lsp_signature_help = false,
      default_mapping = true,
      lsp = {
        servers = {},
        disable_lsp = { "lua_ls" },
      },
    }
  end,
  keys = function()
    return {
      { "gr", require("navigator.reference").reference },
    }
  end,
}
