local M = {}

function M.bufferInfo()
  local pseudoTilde = "∼" -- HACK `U+223C` instead of real `~` to prevent md-strikethrough

  local clients = vim.lsp.get_clients { bufnr = 0 }
  local longestName = vim.iter(clients):fold(0, function(acc, client) return math.max(acc, #client.name) end)
  local lsps = vim.tbl_map(function(client)
    local pad = (" "):rep(math.min(longestName - #client.name) --[[@as integer]]) .. " "
    local root = client.root_dir and client.root_dir:gsub("/Users/%w+", pseudoTilde) or "*Single file mode*"
    return ("[%s]%s%s"):format(client.name, pad, root)
  end, clients)

  local indentType = vim.bo.expandtab and "spaces" or "tabs"
  local indentAmount = vim.bo.expandtab and vim.bo.shiftwidth or vim.bo.tabstop
  local foldexpr = vim.wo.foldexpr:find "lsp" and "LSP" or "TS"

  local out = {
    "[node at pos] " .. (vim.treesitter.get_node() and vim.treesitter.get_node():type() or "n/a"),
    "[bufnr]       " .. vim.api.nvim_get_current_buf(),
    "[winid]       " .. vim.api.nvim_get_current_win(),
    "[filetype]    " .. (vim.bo.filetype == "" and '""' or vim.bo.filetype),
    "[buftype]     " .. (vim.bo.buftype == "" and '""' or vim.bo.buftype),
    "[indent]      " .. ("%s (%d)"):format(indentType, indentAmount),
    "[folds]       " .. ("%s (%d)"):format(foldexpr, vim.wo.foldlevel),
    "[cwd]         " .. (vim.uv.cwd() or "nil"):gsub("/Users/%w+", pseudoTilde),
    "",
  }
  if #lsps > 0 then
    vim.list_extend(out, { "**Attached LSPs with root**", unpack(lsps) })
  else
    vim.list_extend(out, { "*No LSPs attached.*" })
  end
  local opts = { title = "Inspect buffer", icon = "󰽙", timeout = 10000 }
  vim.notify(table.concat(out, "\n"), vim.log.levels.DEBUG, opts)
end

return M
