local M = {
  active = false,
  index = 1,
  ns_id = vim.api.nvim_create_namespace "CodeCompanionSpinner",
  timer = nil,
  frames = require("astroui").get_spinner "LSPLoading",
  filetype = "codecompanion",
}

local function get_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == M.filetype then return buf end
  end
end

local function update()
  if not M.active then
    if M.timer then
      if type(M.timer.stop) == "function" then M.timer:stop() end
      if type(M.timer.close) == "function" then M.timer:close() end
      M.timer = nil
    end
    return
  end

  local buf = get_buf()
  if not buf then return end
  M.index = (M.index % #M.frames) + 1
  vim.api.nvim_buf_clear_namespace(buf, M.ns_id, 0, -1)
  local last_line = vim.api.nvim_buf_line_count(buf) - 1
  vim.api.nvim_buf_set_extmark(buf, M.ns_id, last_line, 0, {
    virt_lines = { { { M.frames[M.index] .. " Processing...", "Comment" } } },
    virt_lines_above = false,
  })
end

function M.start()
  M.active = true
  M.index = 0
  if not M.timer then
    local timer = vim.loop.new_timer()
    if timer and type(timer.start) == "function" then
      M.timer = timer
      M.timer:start(0, 100, vim.schedule_wrap(update))
    end
  end
end

function M.stop()
  M.active = false
  local buf = get_buf()
  if buf then vim.api.nvim_buf_clear_namespace(buf, M.ns_id, 0, -1) end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(event)
      if event.match == "CodeCompanionRequestStarted" then
        M.start()
      elseif event.match == "CodeCompanionRequestFinished" then
        M.stop()
      end
    end,
  })
end

return M
