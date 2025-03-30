local M = {}

M.is_windows = vim.fn.has "win32" == 1
M.is_android = vim.fn.has "android" == 1
M.is_nixos = not not os.getenv "NIX_PATH"
M.is_neovide = vim.g.neovide
M.is_vscode = vim.g.vscode
M.is_firenvim = vim.g.started_by_firenvim

_G.utils = M
return M
