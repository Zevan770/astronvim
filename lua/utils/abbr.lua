local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Cab", function(opts) M.cab(opts.args) end, { nargs = "+" })
  vim.api.nvim_create_user_command("Sab", function(opts) M.sab(opts.args) end, { nargs = "+" })
end

function M.cab(args)
  local lhs, rhs = args:match "^(%S+)%s+(.+)$"
  if lhs and rhs then
    vim.cmd(string.format("cnoreabbrev <expr> %s getcmdtype() ==# ':' ? '%s' : '%s'", lhs, rhs, lhs))
  end
end

function M.sab(args)
  local lhs, rhs = args:match "^(%S+)%s+(.+)$"
  if lhs and rhs then
    vim.cmd(string.format("cnoreabbrev <expr> %s getcmdtype() =~ '[/?]' ? '%s' : '%s'", lhs, rhs, lhs))
  end
end

return M
