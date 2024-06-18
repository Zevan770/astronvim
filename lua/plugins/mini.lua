-- if true then return end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      vim.cmd "source ~/.key.vimrc"
      -- local maps = assert(opts.mappings)
      -- maps.n["<C-u>"] = "<C-u>zz"
      -- maps.n["<C-d>"] = "<C-d>zz"
      -- maps.n["U"] = "<C-r>"
      -- maps.n["H"] = "g^"
      -- maps.n["L"] = "g$"
      -- maps.x["x"] = '"_x'
      -- maps.n["c"] = '"_c'
      -- maps.x["c"] = '"_c'
      -- maps.n["C"] = '"_C'
      -- maps.n["D"] = '"_D'
    end,
  },
}
