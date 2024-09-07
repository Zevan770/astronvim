-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
    -- see zsh as bash
    ["%.zsh"] = "bash",
    ["%.zshrc"] = "bash",
    ["%.zshenv"] = "bash",
    ["%.zprofile"] = "bash",
    ["%.zlogin"] = "bash",
    ["%.zlogout"] = "bash",
    ["%.vindrc"] = "vim",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
    [".*settings.*%.json"] = "jsonc",
    [".*keybindings.*%.json"] = "jsonc",
  },
}

local clip_win32 = {
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

local clip_osc52 = {
  name = "osc52plus",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy,
    ["*"] = require("vim.ui.clipboard.osc52").copy,
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste,
    ["*"] = require("vim.ui.clipboard.osc52").paste,
  },
}

local clip_termux = {
  name = "termux",
  copy = {
    ["+"] = "termux-clipboard-set",
    ["*"] = "termux-clipboard-set",
  },
  paste = {
    ["+"] = "termux-clipboard-get",
    ["*"] = "termux-clipboard-get",
  },
}

vim.g.clipboard = vim.fn.has "android" == 1 and clip_termux or clip_win32
