return {
  {
    "Mr-LLLLL/interestingwords.nvim",
    opts = {
      colors = {
        "#ff4538",
        "#ffe438",
        "#7bff38",
        "#38ff95",
        "#38caff",
        "#4538ff",
        "#e438ff",
        "#ff387b",
        "#ff9538",
        "#caff38",
        "#9538ff",
      },
      -- --"#aeee00", "#ff0000", "#0000ff", "#b88823", "#ffa724", "#ff2c4b" },
      -- colors = (function()
      --   local res = {}
      --   local palette = require("catppuccin.palettes").get_palette()
      --   for _, color in pairs {
      --     "blue",
      --     "flamingo",
      --     "green",
      --     "lavender",
      --     "maroon",
      --     "mauve",
      --     "peach",
      --     "pink",
      --     "red",
      --     "rosewater",
      --     "sapphire",
      --     "sky",
      --     "teal",
      --     "text",
      --     "yellow",
      --   } do
      --     table.insert(res, palette[color])
      --   end
      --   return res
      -- end)(),
      search_count = false,
      navigation = true,
      scroll_center = true,
      search_key = "<leader>*",
      cancel_search_key = "<leader>u*",
      color_key = "<leader>k",
      cancel_color_key = "<leader>uk",
      select_mode = "loop",
    },
  },
}
