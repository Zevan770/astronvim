---@diagnostic disable: duplicate-set-field
local original_vim_keymap_set = vim.keymap.set
--- Table of |:map-arguments|.
--- Same as |nvim_set_keymap()| {opts}, except:
--- - {replace_keycodes} defaults to `true` if "expr" is `true`.
---
--- Also accepts:
--- @class vim.keymap.set.Opts : vim.api.keyset.keymap
--- @inlinedoc
---
--- Creates buffer-local mapping, `0` or `true` for current buffer.
--- @field buffer? integer|boolean
---
--- Make the mapping recursive. Inverse of {noremap}.
--- (Default: `false`)
--- @field remap? boolean

--- Defines a |mapping| of |keycodes| to a function or keycodes.
---
--- Examples:
---
--- ```lua
--- -- Map "x" to a Lua function:
--- vim.keymap.set('n', 'x', function() print("real lua function") end)
--- -- Map "<leader>x" to multiple modes for the current buffer:
--- vim.keymap.set({'n', 'v'}, '<leader>x', vim.lsp.buf.references, { buffer = true })
--- -- Map <Tab> to an expression (|:map-<expr>|):
--- vim.keymap.set('i', '<Tab>', function()
---   return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
--- end, { expr = true })
--- -- Map "[%%" to a <Plug> mapping:
--- vim.keymap.set('n', '[%%', '<Plug>(MatchitNormalMultiBackward)')
--- ```
---
---@param mode string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param lhs string           Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
---
---@see |nvim_set_keymap()|
---@see |maparg()|
---@see |mapcheck()|
---@see |mapset()|
vim.keymap.set = function(mode, lhs, rhs, opts)
  -- if `lhs` is like "[h" or "]h", bracketed,
  -- then change it into something like "<leader>h[]"
  -- 检查lhs是否是字符串
  if type(lhs) == "string" then
    -- 使用pattern匹配"[x"或"]x"格式，其中x是任意字符
    local bracket, key = lhs:match "^([%[%]])(.+)$"

    if bracket and key and #key > 0 then
      -- 将"[h"或"]h"转换为"<leader>h["或"<leader>h]"
      local new_lhs = "<leader>" .. key .. bracket
      return original_vim_keymap_set(mode, new_lhs, rhs, opts)
    end
  end

  -- 对于其他情况，使用原始函数
  return original_vim_keymap_set(mode, lhs, rhs, opts)
end
