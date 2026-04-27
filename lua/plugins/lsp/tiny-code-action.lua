---@type LazySpec
return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = {
          terminal = {},
        },
      },
    },
    event = "LspAttach",
    opts = {
      picker = "snacks",
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>la"] = {
        function() require("tiny-code-action").code_action() end,
        desc = "Code action",
      }
      maps.x["<leader>la"] = maps.n["<leader>la"]

      -- maps.n["<Leader>k"] =
      --   { "<Cmd>Lspsaga hover_doc<CR>", desc = "Hover symbol details", cond = "textDocument/hover" }
    end,
  },
}
