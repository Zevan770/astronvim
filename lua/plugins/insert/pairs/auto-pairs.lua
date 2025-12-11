---@type LazySpec
return {
  "windwp/nvim-autopairs",
  opts = function(_, opts)
    return require("astrocore").extend_tbl({
      enabled = function(bufnr) return true end, -- control if auto-pairs should be enabled when attaching to a buffer
    }, opts)
  end,
  config = function(_, opts)
    require "astronvim.plugins.configs.nvim-autopairs"(opts)
    local Rule = require "nvim-autopairs.rule"
    local npairs = require "nvim-autopairs"
    local cond = require "nvim-autopairs.conds"
    local ar = npairs.add_rule
    local ars = npairs.add_rules
    ars {
      Rule("```", "```", require("utils.filetype").markdown_like):with_pair(cond.not_before_char("`", 3)),
      Rule("```.*$", "```", require("utils.filetype").markdown_like):only_cr():use_regex(true),
    }
  end,
}
