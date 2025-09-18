-- vim.bo.tabstop = 4
-- vim.bo.shiftwidth = 4
vim.wo.wrap = true

local spec_pair = require("mini.ai").gen_spec.pair
vim.b.miniai_config = {
  custom_textobjects = {
    ["8"] = spec_pair("*", "*", { type = "greedy" }),
    ["_"] = spec_pair("_", "_", { type = "greedy" }),
    ["="] = spec_pair("=", "=", { type = "greedy" }),
  },
}
vim.b.minisurround_config = {
  custom_surroundings = {
    ["8"] = {
      input = { "%*%*().-()%*%*" },
      output = { left = "**", right = "**" },
    },
  },
}
