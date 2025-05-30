vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.opt_local.wrap = true

local spec_pair = require("mini.ai").gen_spec.pair
vim.b.miniai_config = {
  custom_textobjects = {
    ["*"] = spec_pair("*", "*", { type = "greedy" }),
    ["_"] = spec_pair("_", "_", { type = "greedy" }),
    ["="] = spec_pair("=", "=", { type = "greedy" }),
  },
}
