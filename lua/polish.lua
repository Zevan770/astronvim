-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

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

vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.g.clipboard = vim.fn.has "android" == 1 and "termux" or "win32yank"
if my_utils.is_vscode then vim.g.clipboard = vim.g.vscode_clipboard end
