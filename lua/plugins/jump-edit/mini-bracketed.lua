---@type LazySpec
return {
  "echasnovski/mini.bracketed",
  event = "User AstroFile",
  -- stylua: ignore
  opts = {
    conflict   = { suffix = "x", options = {} },
    file       = { suffix = "f", options = {} },
    indent     = { suffix = "i", options = {} },
    jump       = { suffix = "j", options = {} },
    location   = { suffix = "", options = {} },
    oldfile    = { suffix = "o", options = {} },
    quickfix   = { suffix = "", options = {} },
    treesitter = { suffix = "t", options = {} },
    yank       = { suffix = "",  options = {} },
    buffer     = { suffix = "",  options = {} },
    undo       = { suffix = "",  options = {} },
    diagnostic = { suffix = "",  options = {} },
    comment    = { suffix = "/", options = {} },
    window     = { suffix = "",  options = {} },
  },
}
