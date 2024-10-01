---@type LazySpec
return {
  {
    "calebfroese/fzf-lua-zoxide",
    enabled = false,
    dependencies = { "ibhagwan/fzf-lua" },
    config = function() require("fzf-lua-zoxide").setup() end,
    opts = function()
      vim.keymap.set("n", "<leader>fz", function()
        require("fzf-lua-zoxide").open {
          ---@field preview? string The command to run in the preview window
          preview = "less -R {}",
          ---@field callback? fun(selected: string) Callback to run on select
          callback = function(selected)
            -- For example, you could open the directory in netrw after selecting one
            -- vim.cmd("e " .. selected)
          end,
        }
      end, { desc = "Fzf Dirs" })
    end,
  },
}
