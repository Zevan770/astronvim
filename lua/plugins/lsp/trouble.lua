---@type LazySpec
return {
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  {
    "folke/trouble.nvim",
    opts = {
      auto_open = false, -- auto open when there are items
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>lx"] = { "<Cmd>Trouble lsp toggle<CR>", desc = "Trouble lsp" }
        end,
      },
    },
  },
}
