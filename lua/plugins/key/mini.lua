-- if true then return end
vim.keymap.set({ "n", "v", "i", "t" }, "<A-q>", "<Cmd>wincmd q<CR>")
-- vim.keymap.set({ "n", "v", "i", "t" }, "<A-h>", "<Cmd>wincmd h<CR>")
-- vim.keymap.set({ "n", "v", "i", "t" }, "<A-j>", "<Cmd>wincmd j<CR>")
-- vim.keymap.set({ "n", "v", "i", "t" }, "<A-k>", "<Cmd>wincmd k<CR>")
-- vim.keymap.set({ "n", "v", "i", "t" }, "<A-l>", "<Cmd>wincmd l<CR>")
---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local mini_path = vim.fn.has "win32" == 1 and "~/.mini.vimrc" or "~/.config/nvim/lua/utils/.mini.vimrc"
      pcall(vim.cmd.source, mini_path)
      -- vim.cmd.source(mini_path)

      local maps = assert(opts.mappings)
      -- maps.n["<C-u>"] = { "<C-u>zz", remap = false }
      -- maps.v["<C-u>"] = { "<C-u>zz", remap = false }
      -- maps.n["<C-d>"] = { "<C-d>zz", remap = false }
      -- maps.v["<C-d>"] = { "<C-d>zz", remap = false }
      maps.n["<C-e>"] = "3<C-e>"
      maps.v["<C-e>"] = "3<C-e>"
      -- maps.i["<C-e>"] = { "<C-\\><C-n>:normal! <C-e><CR>a", noremap = true }
      -- maps.i["<C-e>"] = "<C-o>3<C-e>"
      maps.n["<C-y>"] = "3<C-y>"
      maps.v["<C-y>"] = "3<C-y>"
      -- maps.i["<C-y>"] = { "<C-\\><C-n><Cmd>normal! <C-y><CR>a", noremap = true }
      -- maps.i["<C-y>"] = "<C-o>3<C-y>"
      maps.n[";"] = { ":", remap = true }
      maps.i["jk"] = false
      maps.i["jj"] = false
    end,
  },
}
