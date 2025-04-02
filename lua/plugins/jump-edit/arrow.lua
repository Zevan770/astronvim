-- if true then return {} end
--- @type LazySpec
return {
  "otavioschwanck/arrow.nvim",
  opts = {
    show_icons = true,
    leader_key = "<A-a>", -- Recommended to be a single key
    buffer_leader_key = "<leader>m", -- Per Buffer Mappings
  },
  keys = {
    { "<c-h>", function() require("arrow.persist").previous() end, desc = "Go to previous buffer", mode = { "n" } },
    { "<c-l>", function() require("arrow.persist").next() end, desc = "Go to next buffer", mode = { "n" } },
    { "<a-r>", function() require("arrow.persist").toggle() end, desc = "Toggle buffer", mode = { "n" } },
  },
}
