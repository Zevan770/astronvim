---
--- Quick macro utilities for Neovim, inspired by Helix editor's intuitive macro workflow.
--
-- ## Motivation
-- In Vim, most operations (like `d`, `y`, `c`, `p`) accept a register prefix (e.g., `"a`) to use a specific register, defaulting to `"` if omitted.
-- However, macro recording (`qa`) and playback (`@a`) use a different mental model, requiring explicit register selection every time, which feels inconsistent and interrupts workflow—especially for quick, temporary macros.
--
-- This module unifies the experience: bind the provided functions to keys for one-key macro recording and playback, defaulting to a chosen register. When a different register is needed, simply add the prefix, just like other Vim operations.
--
-- For example, the author prefers to reverse Vim's default mapping: one key to record, one key to play, with optional register prefix for advanced use.
--
-- ## Common Workflow
-- 1. Press your chosen key (e.g. `<leader>q`) to start recording a macro to the default register.
-- 2. Press the same key again to stop recording.
-- 3. Press your play key (e.g. `<leader>@`) to play the macro from the default register.
-- 4. To use a different register, prefix with `"a` (record) or `"a` (play), just like other Vim operations.
--
-- This makes quick, temporary macros much more convenient and intuitive, especially for users familiar with Helix or who want a more unified register workflow.
--
-- ## Example Lua Keymaps
--
-- ```lua
-- vim.keymap.set({"n", "x"}, "<leader>q", require("utils.macros").q, {desc = "Record macro (quick)"})
-- vim.keymap.set({"n", "x"}, "<leader>@", require("utils.macros").play, {desc = "Play macro (quick)"})
-- ```
--
-- @module macros
local M = {}

---
-- Configuration table for macro utilities.
-- @field default_register (string) The default register used for macro recording.
M.config = {
  default_register = "q", -- default macro register
}

---
-- Start or stop macro recording.
-- If already recording, stops recording. Otherwise, starts recording using the current register or the default.
M.q = function()
  if vim.fn.reg_recording() ~= "" then
    -- If recording, stop recording
    vim.api.nvim_feedkeys("q", "n", false)
    return
  end
  local reg = vim.v.register
  if not reg or not reg:match "^[0-9a-zA-Z:/?]$" then reg = M.config.default_register end
  vim.api.nvim_feedkeys("q" .. reg, "n", false)
end

--- NOTE: Nvim default:
--- * Q   play last recorded macro: reg_recorded()
--- * @@  play last played macro
--- what we do: default to play last played macro, else play v:register

---
-- Play a macro.
-- By default, plays the last played macro (register '@'), otherwise uses the current register.
M.play = function()
  local reg = vim.v.register
  if not reg or not reg:match "^[0-9a-zA-Z:/?]$" then reg = "@" end
  vim.api.nvim_feedkeys("@" .. reg, "n", false)
end

return M
