---@type LazySpec
return {
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    event = "User AstroFile",
    opts = {
      lookForwardSmall = 5,
      lookForwardBig = 15,
      useDefaultKeymaps = true,
      disabledKeymaps = {
        "gw",
        "n",
        "r",
        "R",
        "L",
        "in",
        "an",
        "ig",
        "ag",
      },
      notifyNotFound = true,
    },
  },
}
