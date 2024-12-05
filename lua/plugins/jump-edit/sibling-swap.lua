---@type LazySpec
return {
  {
    "Wansmer/sibling-swap.nvim",
    opts = {
      allowed_separators = {
        ",",
        ";",
        "and",
        "or",
        "&&",
        "&",
        "||",
        "|",
        "==",
        "===",
        "!=",
        "!==",
        "-",
        "+",
        ["<"] = ">",
        ["<="] = ">=",
        [">"] = "<",
        [">="] = "<=",
      },
      ignore_injected_langs = false,
      use_default_keymaps = false,
      -- allow swaps across lines
      allow_interline_swaps = true,
      -- swaps interline siblings without separators (no recommended, helpful for swaps html-like attributes)
      interline_swaps_without_separator = false,
      -- Fallbacs for tiny settings for langs and nodes. See #fallback
      fallback = {},
    },
    keys = {
      {
        "<leader>.",
        function() require("sibling-swap").swap_with_right() end,
        desc = "swap with right sibling",
        mode = { "n", "v" },
      },
      {
        "<leader>,",
        function() require("sibling-swap").swap_with_left() end,
        desc = "swap with left sibling",
        mode = { "n", "v" },
      },
    },
  },
}
