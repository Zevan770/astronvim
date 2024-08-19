---@type LazySpec
return {
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    event = "User AstroFile",
    opts = {
      -- useDefaultKeymaps = true,
      disabledKeyMaps = {
        "n",
        "r",
        "L",
        "in",
        "an",
        "ig",
        "ag",
      },
    },
  },
}
