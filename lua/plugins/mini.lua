-- if true then return end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      vim.cmd "source ~/.mini.vimrc"
      local maps = assert(opts.mappings)
      maps.n["<C-u>"] = { "<C-u>zz", remap = false }
      maps.v["<C-u>"] = { "<C-u>zz", remap = false }
      maps.n["<C-d>"] = { "<C-d>zz", remap = false }
      maps.v["<C-d>"] = { "<C-d>zz", remap = false }
      maps.n["<C-e>"] = "3<C-e>"
      maps.v["<C-e>"] = "3<C-e>"
      maps.i["<C-e>"] = { "<C-\\><C-n>:normal! <C-e><CR>a", noremap = true }
      -- maps.i["<C-e>"] = "<C-o>3<C-e>"
      maps.n["<C-y>"] = "3<C-y>"
      maps.v["<C-y>"] = "3<C-y>"
      maps.i["<C-y>"] = { "<C-\\><C-n><Cmd>normal! <C-y><CR>a", noremap = true }
      -- maps.i["<C-y>"] = "<C-o>3<C-y>"
      maps.n[";"] = { ":", remap = true }
    end,
  },
}
