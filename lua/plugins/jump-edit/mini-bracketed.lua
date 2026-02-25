---@type LazySpec
return {
  "echasnovski/mini.bracketed",
  -- stylua: ignore
  opts = {
    conflict   = { suffix = "x", options = {} },
    file       = { suffix = "", options = {} },
    indent     = { suffix = "i", options = {} },
    jump       = { suffix = "j", options = {} },
    location   = { suffix = "l", options = {} },
    oldfile    = { suffix = "o", options = {} },
    quickfix   = { suffix = "q", options = {} },
    treesitter = { suffix = "t", options = {} },
    yank       = { suffix = "y",  options = {} },
    buffer     = { suffix = "",  options = {} },
    undo       = { suffix = "u",  options = {} },
    diagnostic = { suffix = "d",  options = {} },
    comment    = { suffix = "/", options = {} },
    window     = { suffix = "",  options = {} },
  },
  keys = {
    "[",
    "]",
  },
}
