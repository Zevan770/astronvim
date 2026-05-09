---@type LazySpec
return {
  {
    "aaronik/treewalker.nvim",
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = "CursorLine",

      -- Whether to create a visual selection after a movement to a node.
      -- If true, highlight is disabled and a visual selection is made in
      -- its place.
      select = false,

      -- Whether to use vim.notify to warn when there are missing parsers or incorrect options
      notifications = true,

      -- Whether the plugin adds movements to the jumplist -- true | false | 'left'
      --  true: All movements more than 1 line are added to the jumplist. This is the default,
      --        and is meant to cover most use cases. It's modeled on how { and } natively add
      --        to the jumplist.
      --  false: Treewalker does not add to the jumplist at all
      --  "left": Treewalker only adds :Treewalker Left to the jumplist. This is usually the most
      --          likely one to be confusing, so it has its own mode.
      jumplist = true,
    },
    keys = function()
      local result = {}
      local to_arrow = {
        h = "out",
        j = "down",
        k = "up",
        l = "in",
      }
      for letter, dir in pairs(to_arrow) do
        result[#result + 1] = {
          "<c-" .. letter .. ">",
          function()
            local ok = pcall(require("treewalker")["move_" .. dir])
            if not ok then vim.cmd.normal(letter) end
          end,
          mode = { "n", "x" },
          desc = "Treewalker " .. require("coerce.case").to_pascal_case(dir),
        }
      end
      return result
    end,
  },

  {
    "dkendal/nvim-treeclimber",
    enabled = false,
    -- enabled = my_utils.is_nixos,
    config = function() require("nvim-treeclimber").setup {} end,
    keys = {
      -- Core navigation
      { "<C-k>", "<Plug>(treeclimber-select-previous)", mode = { "n", "x", "o" } },
      { "<C-j>", "<Plug>(treeclimber-select-next)", mode = { "n", "x", "o" } },
      { "<C-h>", "<Plug>(treeclimber-select-parent)", mode = { "n", "x", "o" } },
      { "<C-l>", "<Plug>(treeclimber-select-shrink)", mode = { "n", "x", "o" } },
      -- Growth selection
      { "<C-S-k>", "<Plug>(treeclimber-select-grow-backward)", mode = { "n", "x", "o" } },
      { "<C-S-j>", "<Plug>(treeclimber-select-grow-forward)", mode = { "n", "x", "o" } },
      -- Sibling navigation
      { "<M-[>", "<Plug>(treeclimber-select-siblings-backward)", mode = { "n", "x", "o" } },
      { "<M-]>", "<Plug>(treeclimber-select-siblings-forward)", mode = { "n", "x", "o" } },
      -- Top level
      { "<M-g>", "<Plug>(treeclimber-select-top-level)", mode = { "n", "x", "o" }, desc = "Select top-level node" },
      -- Movement selection
      { "<M-b>", "<Plug>(treeclimber-select-backward)", mode = { "n", "x", "o" } },
      { "<M-e>", "<Plug>(treeclimber-select-forward-end)", mode = { "n", "x", "o" } },
      -- Commands
      { "<leader>xo", "<Plug>(treeclimber-show-control-flow)", mode = "n" },
    },
    cmd = { "TCDiffThis", "TCShowControlFlow", "TCHighlightExternalDefinitions" },
  },
  {
    "gsuuon/tshjkl.nvim",
    keys = { "<A-v>" },
    config = true,
  },
}
