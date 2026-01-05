---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        interactions = {
          chat = {
            keymaps = (function()
              local keymaps = vim.deepcopy(require("codecompanion.config").config.interactions.chat.keymaps)
              -- Iterate over all keymaps, normalize the keys under `modes`, and replace keys that start with 'g'
              -- Use `pairs` instead of `ipairs` to support `keymaps` being a map (not necessarily an array)
              for _, keymap in pairs(keymaps) do
                -- Ensure `modes` is not a single string (if it is, wrap it into a table)
                if type(keymap.modes) == "string" then keymap.modes = { keymap.modes } end

                -- To avoid modifying the original table while iterating (which can cause unexpected issues),
                -- build a new `modes` table and populate it with the processed data
                local new_modes = {}
                for mode, keys in pairs(keymap.modes or {}) do
                  -- Wrap single-string `keys` into a table; if it's not a table, set it to an empty table
                  if type(keys) == "string" then
                    keys = { keys }
                  elseif type(keys) ~= "table" then
                    keys = {}
                  end

                  -- Process each item in the `keys` table (modify the `keys` table in place)
                  for i, key in ipairs(keys) do
                    if type(key) == "string" and key:sub(1, 1) == "g" then keys[i] = "<localleader>" .. key:sub(2) end
                  end
                  if #keys == 1 then keys = keys[1] end

                  new_modes[mode] = keys
                end

                keymap.modes = new_modes
              end
              return require("astrocore").extend_tbl(keymaps, {
                close = {
                  modes = {
                    n = "q",
                  },
                },
                stop = {
                  modes = {
                    n = "<c-c>",
                  },
                },
              })
            end)(),
          },
        },
      })
    end,
  },
}
