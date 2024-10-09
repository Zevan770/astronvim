-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
    ahk2 = "autohotkey",
    ahk1 = "autohotkey",
    -- log = "logtalk",
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
    ["github%.com_*%.txt"] = "markdown",
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
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy "+",
    ["*"] = require("vim.ui.clipboard.osc52").copy "*",
  },
  paste = {
    ["+"] = function() end,
    ["*"] = function() end,
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

local clip_windows = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
  },
  cache_enabled = true, -- 或者使用 false 来表示布尔值
}

vim.g.clipboard = vim.fn.has "android" == 1 and clip_termux or clip_win32
