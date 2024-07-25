if true then return {} end
---@type LazySpec
return {
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      maps.n["<Leader>j"] = { desc = "+Jump" }
      maps.n["<Leader>jv"] = { function() require("dropbar.api").pick() end, desc = "breadcrumbs/dropbar" }
    end,
  },
}
