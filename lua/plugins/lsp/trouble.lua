---@type LazySpec
return {
  {
    "folke/trouble.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>x"
          maps.n["<Leader>lx"] = { "<Cmd>Trouble lsp toggle<CR>", desc = "Trouble lsp" }
        end,
      },
    },
  },
}
