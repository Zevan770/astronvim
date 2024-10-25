if true then return {} end
--- @type LazySpec
return {
  {
    "cbochs/grapple.nvim",
    opts = {
      scope = "git", -- also try out "git_branch"
      icons = false, -- setting to "true" requires "nvim-web-devicons"
      status = false,
    },
    keys = {
      { "<leader><leader>", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
      { "<c-t>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

      { "<c-1>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
      { "<c-2>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
      { "<c-3>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
      { "<c-4>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

      { "<c-h>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
      { "<c-l>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader><Leader>"
          -- maps.n[prefix] = { desc = require("astroui").get_icon("Grapple", 1, true) .. "Grapple" }
          -- maps.n[prefix .. "a"] = { "<Cmd>Grapple tag<CR>", desc = "Add file" }
          -- maps.n[prefix .. "d"] = { "<Cmd>Grapple untag<CR>", desc = "Remove file" }
          -- maps.n[prefix .. "t"] = { "<Cmd>Grapple toggle_tags<CR>", desc = "Toggle a file" }
          -- maps.n[prefix .. "e"] = { "<Cmd>Grapple toggle_scopes<CR>", desc = "Select from tags" }
          -- maps.n[prefix .. "s"] = { "<Cmd>Grapple toggle_loaded<CR>", desc = "Select a project scope" }
          -- maps.n[prefix .. "x"] = { "<Cmd>Grapple reset<CR>", desc = "Clear tags from current project" }
          -- maps.n["<C-n>"] = { "<Cmd>Grapple cycle forward<CR>", desc = "Select next tag" }
          -- maps.n["<C-p>"] = { "<Cmd>Grapple cycle backward<CR>", desc = "Select previous tag" }
        end,
      },
    },
  },
}
