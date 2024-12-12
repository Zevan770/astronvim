---@type LazySpec
return {
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    event = "User AstroFile",
    opts = {
      forwardLooking = { small = 5, big = 15 },
      useDefaultKeymaps = true,
      disabledKeymaps = {
        "gw",
        "n",
        "r",
        "R",
        "L",
        "Q",
        "in",
        "an",
        "ig",
        "ag",
      },
      notify = {
        whenObjectNotFound = true,
      },
    },
  },
}
