-- if true then return end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      vim.cmd "source ~/.config/minimal-vim/.mini.vimrc"
      vim.g.clipboard = {
        name = "win32yank-wsl",
        copy = {
          ["+"] = "win32yank.exe -i --crlf",
          ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
          ["+"] = "win32yank.exe -o --lf",
          ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = true,
      }
      -- vim.g.clipboard = {
      --   name = "WslClipboard",
      --   copy = {
      --     ["+"] = "clip.exe",
      --     ["*"] = "clip.exe",
      --   },
      --   paste = {
      --     ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
      --     ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
      --   },
      --   cache_enabled = true, -- 或者使用 false 来表示布尔值
      -- }

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
      maps.i["jk"] = false
      maps.i["jj"] = false
    end,
  },
}
