---@type LazySpec
return {
  "stevearc/stickybuf.nvim",
  event = "UIEnter",
  opts = {
    get_auto_pin = function(bufnr)
      -- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned.
      -- You can instead return an table that will be passed in as "opts" to `stickybuf.pin`.
      -- The function below encompasses the default logic. Inspect the source to see what it does.
      return require("stickybuf").should_auto_pin(bufnr)
    end,
  },
}
