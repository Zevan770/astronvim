---@module 'snacks'

-- Utility for extending tables
---@generic T
---@param from `T`
---@param fun? fun(copy: T): T?
local function extend(from, fun)
  local copy = vim.deepcopy(from)
  return fun and (fun(copy) or copy) or copy
end

---@type table<string, snacks.picker.layout.Config>
local user_layouts = {
  -- ! Define layouts here
  better_telescope = {
    layout = {
      box = "horizontal",
      width = 0.9,
      height = 0.9,
      backdrop = false,
      {
        box = "vertical",
        border = "single",
        title = "{title} {live} {flags}",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
      },
      { win = "preview", width = 0.5, border = "single", title = "{preview}" },
    },
  },
  sidebar = { --[[Override]]
    auto_hide = { "preview" },
    layout = {
      backdrop = false,
      width = 40,
      min_width = 40,
      height = 0,
      position = "left",
      border = "none",
      box = "vertical",
      {
        win = "input",
        height = 1,
        border = "single",
        title = "{title} {live} {flags}",
        title_pos = "center",
      },
      { win = "list", border = "none" },
      { win = "preview", title = "{preview}", height = 0.4, border = "top" },
    },
  },
}

user_layouts.better_telescope_alt = extend(user_layouts.better_telescope, function(ly) ly.layout[2].width = 0.6 end)

---@table <string, string|fun(source: string):string>
local presets = {
  better_telescope = function() return vim.o.columns >= 120 and "better_telescope" or "vertical" end,
  better_telescope_alt = function() return vim.o.columns >= 120 and "better_telescope_alt" or "vertical" end,
}

---@alias CycleState {index:number,last_preset:string}

---@class snacks.Picker
---@field state { cycle?:CycleState, up_stack?:string[] }?

---@alias When fun(picker:snacks.Picker,preset:string,source:string?):boolean
---@alias What fun(picker:snacks.Picker,layout:snacks.picker.layout.Config):snacks.picker.layout.Config[]
---@alias CycleConfig { [1]: When, [2]: What }

---@type CycleConfig[]
-- stylua: ignore
local cycle_config = {
  {
    function(_, preset) return preset:match '^vertical' end,
    function(_, layout)
      local layouts = require('snacks.picker.config.layouts')
      return {
        extend(layout),
        extend(layouts.vertical),
        extend(layouts.vertical, function(ly) ly.layout[3].height = 0.7 end),
        extend(user_layouts.better_telescope, function(ly) ly.layout[2].width = 0.1 end),
        extend(user_layouts.better_telescope),
        extend(user_layouts.better_telescope, function(ly) ly.layout[2].width = 0.9 end),
      }
    end,
  },
  {
    function(_, preset) return preset:match '^ivy' end,
    function(_, layout)
      return {
        extend(layout),
        extend(layout, function(ly) ly.layout.height = 0.7 end),
      }
    end,
  },
  {
    function(_, preset) return preset:match '^better_telescope' end,
    function(_, layout)
      return {
        extend(layout),
        extend(layout, function(ly) ly.layout[2].width = 0.1 end),
        extend(layout, function(ly) ly.layout[2].width = 0.9 end),
      }
    end,
  },
}

---@param direction 'next'|'prev'
local cycle_action = function(direction)
  ---@type fun(picker:snacks.Picker, item:snacks.picker.Item, action:snacks.picker.Action): boolean|string?
  return function(picker, _, _)
    picker.state = vim.tbl_extend("keep", picker.state or {}, {
      cycle = { index = 1, last_preset = nil },
    })
    local layout_config = Snacks.picker.config.layout(picker.opts)
    local source = picker.init_opts.source or ""
    local preset
    if type(layout_config.preset) == "function" then
      preset = layout_config.preset(source)
    else
      preset = layout_config.preset --[[@as string?]]
    end
    preset = preset or ""
    local config ---@type CycleConfig?
    config = vim.iter(cycle_config):find(function(conf) ---@param conf CycleConfig
      return conf[1](picker, preset, source)
    end)
    if not config then return end
    local layouts = config[2](picker, layout_config)
    local state = picker.state.cycle --[[@as CycleState]]
    if direction == "prev" then state.index = state.index > 1 and state.index - 1 or #layouts end
    if direction == "next" then state.index = state.index < #layouts and state.index + 1 or 1 end
    state.last_preset = preset
    picker:set_layout(layouts[state.index])
  end
end

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      layouts = user_layouts,
      layout = {
        preset = presets.better_telescope,
      },
      actions = {
        cycle_layout_prev = cycle_action "prev",
        cycle_layout_next = cycle_action "next",
      },
      win = {
        input = {
          keys = {
            ["<M-n>"] = { "cycle_layout_next", mode = { "i", "n" } },
            ["<M-S-n>"] = { "cycle_layout_prev", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<M-n>"] = "cycle_layout_next",
            ["<M-S-n>"] = "cycle_layout_next",
          },
        },
        preview = {
          keys = {
            ["<M-n>"] = "cycle_layout_next",
            ["<M-S-n>"] = "cycle_layout_next",
          },
        },
      },
      ---@class snacks.picker.sources.Config
      ---@diagnostic disable-next-line: duplicate-doc-field
      ---@field [string] snacks.picker.Config|{}
      sources = extend({
        -- ! Define sources here
        explorer = {
          layout = {
            preset = "sidebar",
            preview = "main",
          },
        },
      } --[[@as snacks.picker.sources.Config]], function(sources)
        for _, name in ipairs {
          "buffers",
          "cliphist",
          "commands",
          "files",
          "git_diff",
          "git_status",
          "help",
          "highlights",
          "lsp_symbols",
          "pickers",
          "picker_actions",
          "picker_format",
          "picker_layouts",
          "picker_preview",
          "projects",
          "recent",
          "treesitter",
          "undo",
          "zoxide",
        } do
          sources[name] = vim.tbl_extend("keep", sources[name] or {}, {
            layout = {
              preset = presets.better_telescope_alt,
            },
          })
        end
      end),
    },
  },
}
