local M = {}

if my_utils.is_vscode then table.insert(M, { import = "os.vscode" }) end
if my_utils.is_nixos then table.insert(M, { import = "os.nixos" }) end
if my_utils.is_android then table.insert(M, { import = "os.termux" }) end
if my_utils.is_windows then table.insert(M, { import = "os.windows" }) end
if my_utils.is_firenvim then table.insert(M, { import = "os.firenvim" }) end
if my_utils.is_server then table.insert(M, { import = "os.server" }) end
return M
