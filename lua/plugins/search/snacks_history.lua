---@module 'snacks'
return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        actions = {
          choose_history = function(picker)
            local history = picker.history.kv.data
            local items = {}
            for i = 1, #history do
              local hist = history[#history + 1 - i]
              table.insert(items, {
                idx = i,
                pattern = hist.pattern,
                search = hist.search,
                live = hist.live,
                text = hist.search .. " " .. hist.pattern,
              })
            end
            Snacks.picker.pick {
              title = "Picker history",
              items = items,
              main = { current = true }, -- NOTE: Prevent closing the parent picker
              layout = { preset = "select" },
              supports_live = false,
              transform = function(item) return not (item.pattern == "" and item.search == "") end,
              format = function(item)
                local ico = { live = picker.opts.icons.ui.live, prompt = picker.opts.prompt }
                local part1 = item.live and item.pattern or item.search
                local part2 = item.live and item.search or item.pattern
                --
                local text = {}
                table.insert(text, { item.live and ico.live or "  ", "Special" })
                table.insert(text, { " " })
                table.insert(text, { part1, "SnacksPickerInputSearch" })
                if part1 ~= "" and part2 ~= "" then
                  table.insert(text, { " " })
                  table.insert(text, { ico.prompt, "SnacksPickerPrompt" })
                end
                table.insert(text, { part2 })
                return text
              end,
              confirm = function(history_picker, item)
                local mode = vim.fn.mode()
                picker.opts.live = item.live
                picker.input:set(item.pattern, item.search)
                history_picker:close()
                if mode == "i" then
                -- stylua: ignore
                vim.schedule(function() vim.cmd 'startinsert!' end)
                end
              end,
            }
          end,
        },
        win = {
          input = {
            keys = {
              ["<M-r>"] = { "choose_history", mode = { "i", "n" } },
            },
          },
        },
      },
    },
  },
}
