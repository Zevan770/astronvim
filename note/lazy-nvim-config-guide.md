## `LazySpec`

这是相关文档和示例。
注意最重要的是插件配置部分，opts 和 config 的关系

2025-07-03
abc123abc

- 如果一个插件有多个 `Spec`, 每一个 `Spec` 的 `opts` 会合并最终传给`config`
  合并方式根据 opts 的具体形式，有三种：

  ```lua
  ---will be merged
  opts = { top_level = { some_options = "" } }
  ---will replaces the old one
  opts = function()
    return {
      -- a new table
    }
  end
  ---will replaces opts with the one merged by extend_tbl
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      ---some extra configs
    })
  end
  ---will simply change the table
  opts = function()
    opts.some_option = "new_value"
    opts.top_level = opts.top_level or {} -- validate
    opts.top_level.another_option = "new_value"
    --- no return value
  end
  ```

  ```help

  opts       table or                      opts should be a table (will be merged with parent
             fun(LazyPlugin, opts:table)   specs), return a table (replaces parent specs) or should
                                           change a table (when opts is a function without return value). The table will be passed to the
                                           Plugin.config() function. Setting this value will imply
                                           Plugin.config()
  ```

- 而 `config = true` 等价于 `config = function(_, opts) require("this-plug").setup(opts)`, 多个`config`只会相互替代。
  因此常用`opts`进行配置，除非有特殊需求，比如需要在 setup 之前或之后做一些事情

```help
==============================================================================
4. 🔌 Plugin Spec                               *lazy.nvim-🔌-plugin-spec*


SPEC SOURCE                           *lazy.nvim-🔌-plugin-spec-spec-source*

  -----------------------------------------------------------------------------------
  Property   Type       Description
  ---------- ---------- -------------------------------------------------------------
  [1]        string?    Short plugin url. Will be expanded using
                        config.git.url_format. Can also be a url or dir.

  dir        string?    A directory pointing to a local plugin

  url        string?    A custom git url where the plugin is hosted

  name       string?    A custom name for the plugin used for the local plugin
                        directory and as the display name

  dev        boolean?   When true, a local plugin directory will be used instead. See
                        config.dev
  -----------------------------------------------------------------------------------
A valid spec should define one of `[1]`, `dir` or `url`.


SPEC LOADING                         *lazy.nvim-🔌-plugin-spec-spec-loading*

  --------------------------------------------------------------------------------------------------
  Property       Type                      Description
  -------------- ------------------------- ---------------------------------------------------------
  dependencies   LazySpec[]                A list of plugin names or plugin specs that should be
                                           loaded when the plugin loads. Dependencies are always
                                           lazy-loaded unless specified otherwise. When specifying a
                                           name, make sure the plugin spec has been defined
                                           somewhere else.

  enabled        boolean? or fun():boolean When false, or if the function returns false, then this
                                           plugin will not be included in the spec

  cond           boolean? or               Behaves the same as enabled, but won’t uninstall the
                 fun(LazyPlugin):boolean   plugin when the condition is false. Useful to disable
                                           some plugins in vscode, or firenvim for example.

  priority       number?                   Only useful for start plugins (lazy=false) to force
                                           loading certain plugins first. Default priority is 50.
                                           It’s recommended to set this to a high number for
                                           colorschemes.
  --------------------------------------------------------------------------------------------------

SPEC SETUP                             *lazy.nvim-🔌-plugin-spec-spec-setup*

  --------------------------------------------------------------------------------------------------
  Property   Type                          Description
  ---------- ----------------------------- ---------------------------------------------------------
  init       fun(LazyPlugin)               init functions are always executed during startup. Mostly
                                           useful for setting vim.g.* configuration used by Vim
                                           plugins startup

  opts       table or                      opts should be a table (will be merged with parent
             fun(LazyPlugin, opts:table)   specs), return a table (replaces parent specs) or should
                                           change a table. The table will be passed to the
                                           Plugin.config() function. Setting this value will imply
                                           Plugin.config()

  config     fun(LazyPlugin, opts:table)   config is executed when the plugin loads. The default
             or true                       implementation will automatically run
                                           require(MAIN).setup(opts) if opts or config = true is
                                           set. Lazy uses several heuristics to determine the
                                           plugin’s MAIN module automatically based on the plugin’s
                                           name. (opts is the recommended way to configure plugins).

  main       string?                       You can specify the main module to use for config() and
                                           opts(), in case it can not be determined automatically.
                                           See config()

  build      fun(LazyPlugin) or string or  build is executed when a plugin is installed or updated.
             false or a list of build      See Building for more information.
             commands
  --------------------------------------------------------------------------------------------------
Always use `opts` instead of `config` when possible. `config` is almost never
needed.




SPEC LAZY LOADING               *lazy.nvim-🔌-plugin-spec-spec-lazy-loading*

  --------------------------------------------------------------------------------------------------------------------
  Property   Type                                                             Description
  ---------- ---------------------------------------------------------------- ----------------------------------------
  lazy       boolean?                                                         When true, the plugin will only be
                                                                              loaded when needed. Lazy-loaded plugins
                                                                              are automatically loaded when their Lua
                                                                              modules are required, or when one of the
                                                                              lazy-loading handlers triggers

  event      string? or string[] or                                           Lazy-load on event. Events can be
             fun(self:LazyPlugin, event:string[]):string[] or                 specified as BufEnter or with a pattern
             {event:string[]\|string, pattern?:string[]\|string}              like BufEnter *.lua

  cmd        string? or string[] or                                           Lazy-load on command
             fun(self:LazyPlugin, cmd:string[]):string[]

  ft         string? or string[] or                                           Lazy-load on filetype
             fun(self:LazyPlugin, ft:string[]):string[]

  keys       string? or string[] or LazyKeysSpec[] or                         Lazy-load on key mapping
             fun(self:LazyPlugin, keys:string[]):(string \| LazyKeysSpec)[]
  --------------------------------------------------------------------------------------------------------------------
Refer to the Lazy Loading <./lazy_loading.md> section for more information.


SPEC VERSIONING                   *lazy.nvim-🔌-plugin-spec-spec-versioning*

  ------------------------------------------------------------------------------
  Property     Type                 Description
  ------------ -------------------- --------------------------------------------
  branch       string?              Branch of the repository

  tag          string?              Tag of the repository

  commit       string?              Commit of the repository

  version      string? or false to  Version to use from the repository. Full
               override the default Semver ranges are supported

  pin          boolean?             When true, this plugin will not be included
                                    in updates

  submodules   boolean?             When false, git submodules will not be
                                    fetched. Defaults to true
  ------------------------------------------------------------------------------
Refer to the Versioning <./versioning.md> section for more information.


SPEC ADVANCED                       *lazy.nvim-🔌-plugin-spec-spec-advanced*

  ----------------------------------------------------------------------------------------
  Property   Type       Description
  ---------- ---------- ------------------------------------------------------------------
  optional   boolean?   When a spec is tagged optional, it will only be included in the
                        final spec, when the same plugin has been specified at least once
                        somewhere else without optional. This is mainly useful for Neovim
                        distros, to allow setting options on plugins that may/may not be
                        part of the user’s plugins.

  specs      LazySpec   A list of plugin specs defined in the scope of the plugin. This is
                        mainly useful for Neovim distros, to allow setting options on
                        plugins that may/may not be part of the user’s plugins. When the
                        plugin is disabled, none of the scoped specs will be included in
                        the final spec. Similar to dependencies without the automatic
                        loading of the specs.

  module     false?     Do not automatically load this Lua module when it’s required
                        somewhere

  import     string?    Import the given spec module.
  ----------------------------------------------------------------------------------------

EXAMPLES                                 *lazy.nvim-🔌-plugin-spec-examples*

>lua
    return {
      -- the colorscheme should be available when starting Neovim
      {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
          -- load the colorscheme here
          vim.cmd([[colorscheme tokyonight]])
        end,
      },

      -- I have a separate config.mappings file where I require which-key.
      -- With lazy the plugin will be automatically loaded when it is required somewhere
      { "folke/which-key.nvim", lazy = true },

      {
        "nvim-neorg/neorg",
        -- lazy-load on filetype
        ft = "norg",
        -- options for neorg. This will automatically call `require("neorg").setup(opts)`
        opts = {
          load = {
            ["core.defaults"] = {},
          },
        },
      },

      {
        "dstein64/vim-startuptime",
        -- lazy-load on a command
        cmd = "StartupTime",
        -- init is called during startup. Configuration for vim plugins typically should be set in an init function
        init = function()
          vim.g.startuptime_tries = 10
        end,
      },

      {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
        },
        config = function()
          -- ...
        end,
      },

      -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
      -- So for api plugins like devicons, we can always set lazy=true
      { "nvim-tree/nvim-web-devicons", lazy = true },

      -- you can use the VeryLazy event for things that can
      -- load later and are not important for the initial UI
      { "stevearc/dressing.nvim", event = "VeryLazy" },

      {
        "Wansmer/treesj",
        keys = {
          { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
        opts = { use_default_keymaps = false, max_join_length = 150 },
      },

      {
        "monaqa/dial.nvim",
        -- lazy-load on keys
        -- mode is `n` by default. For more advanced options, check the section on key mappings
        keys = { "<C-a>", { "<C-x>", mode = "n" } },
      },

<
```

### types

```lua

---@class LazyPluginBase
---@field [1] string?
---@field name string display name and name used for plugin config files
---@field main? string Entry module that has setup & deactivate
---@field url string?
---@field dir string
---@field enabled? boolean|(fun():boolean)
---@field cond? boolean|(fun():boolean)
---@field optional? boolean If set, then this plugin will not be added unless it is added somewhere else
---@field lazy? boolean
---@field priority? number Only useful for lazy=false plugins to force loading certain plugins first. Default priority is 50
---@field dev? boolean If set, then link to the respective folder under your ~/projects
---@field rocks? string[]
---@field virtual? boolean virtual plugins won't be installed or added to the rtp.

---@class LazyPlugin: LazyPluginBase,LazyPluginHandlers,LazyPluginHooks,LazyPluginRef
---@field dependencies? string[]
---@field specs? string|string[]|LazyPluginSpec[]
---@field _ LazyPluginState

---@class LazyPluginSpecHandlers
---@field event? string[]|string|LazyEventSpec[]|fun(self:LazyPlugin, event:string[]):string[]
---@field cmd? string[]|string|fun(self:LazyPlugin, cmd:string[]):string[]
---@field ft? string[]|string|fun(self:LazyPlugin, ft:string[]):string[]
---@field keys? string|string[]|LazyKeysSpec[]|fun(self:LazyPlugin, keys:string[]):((string|LazyKeys)[])
---@field module? false

---@class LazyPluginSpec: LazyPluginBase,LazyPluginSpecHandlers,LazyPluginHooks,LazyPluginRef
---@field name? string display name and name used for plugin config files
---@field dir? string
---@field dependencies? string|string[]|LazyPluginSpec[]
---@field specs? string|string[]|LazyPluginSpec[]

---@alias LazySpec string|LazyPluginSpec|LazySpecImport|LazySpec[]

---@class LazySpecImport
---@field import string|(fun():LazyPluginSpec) spec module to import
---@field name? string
---@field enabled? boolean|(fun():boolean)
---@field cond? boolean|(fun():boolean)
```

## 键映射相关

四种方式映射：

### LazySpec.keys

lazy.nvim 自带的功能，keys：Lazy-load on key mapping，可以实际定义键功能，也可以只描述键名 (通常用于这些键已经被插件映射，只需 lazyvim 检测 lazy-load)

```lua
---@field keys? string|string[]|LazyKeysSpec[]|fun(self:LazyPlugin, keys:string[]):((string|LazyKeys)[])
```

```lua
      {
        "Wansmer/treesj",
        keys = {
          { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
      },
      {
        "monaqa/dial.nvim",
        -- lazy-load on keys
        -- mode is `n` by default. For more advanced options, check the section on key mappings
        keys = { "<C-a>", { "<C-x>", mode = "n" } },
      },
```

### `AstroCoreOpts.mappings`

需要将`astrocore`放进插件的`dependencies`里面，然后修改 `astrocore` 的 opts.mappings 字段。
AstroNvim 使用 Astrocore 进行键映射的目的是让 AstroNvim 定义的所有映射，在 astrocore 插件的 opts 被解析完成前，所有映射都只是保存在一个表里，而不是真正的进行映射。
这样，用户就可以对 mappings 字段增删改，随意操作。也就是说做到了让其定义的所有映射都是可选的

types:

```lua
---@class AstroCoreMapping: vim.api.keyset.keymap
---@field [1] AstroCoreMappingCmd? rhs of keymap

---@alias AstroCoreMappings table<string,table<string,(AstroCoreMapping|AstroCoreMappingCmd|false)?>?>

---@alias AstroCoreMappingCmd string|function
```

```lua
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        for _, mode in ipairs { "n", "v" } do
          maps[mode]["<Leader>gy"] = { "<Cmd>GitLink<CR>", desc = "Git link copy" }
          maps[mode]["<Leader>gz"] = { "<Cmd>GitLink!<CR>", desc = "Git link open" }
        end
      end,
    },
    opts = {},
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts) -- Configure core features of AstroNvim
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      local maps = assert(opts.mappings)
      local astro = require "astrocore"

      maps.n["<Leader>a"] = { desc = "Appalication" }
    end
  },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      --- 复杂的例子
      local maps = opts.mappings
      replace_group = function(modes, maps, group, new_group)
        if type(modes) == "string" then modes = { modes } end
        for _, mode in ipairs(modes) do
          for k, v in pairs(maps[mode]) do
            if k:find(group) then
              if new_group then maps[mode][k:gsub(group, new_group)] = v end
              maps[mode][k] = false
            end
          end
        end
      end
      replace_group("n", maps, "<leader>M", "<Leader>:")
    end,
  },
```

### `astrocore.set_mappins`

```lua

--- Table based API for setting keybindings
--- 有 rhs 则 vim.keymap.set, 没有 rhs 则自动添加到 which-key
---@param map_table AstroCoreMappings A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? vim.keymap.set.Opts A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
```

上述 `AstroCoreMappings` 在底层使用这个函数。手动调用`set_mappings`通常用于在插件自定义的类似`on_attach`, `hook`, 的字段中，或是 autocmd 中进行映射，以实现条件映射。

> [!example]
> hello
> world

### 插件 opts 中自定义的键映射字段

只给例子，因为插件自定义的映射方式往往不遵循 `vim.api.keyset.opts`

#### 插件提供这种方式，一般有几种考虑：

##### 1. 方便用户配置：

将功能作为 key, 而按键作为值，用户只需配置按键即可，例如

```lua
{
  "echasnovski/mini.move",
  event = "User AstroFile",
  version = false,
  -- No need to copy this inside `setup()`. Will be used automatically.
  opts = {
    -- Module mappings. Use `''` (empty string) to disable one.
    -- Created for both Normal and Visual modes.
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = "<M-h>",
      right = "<M-l>",
      down = "<M-j>",
      up = "<M-k>",
    },
  },
},
```

##### 2. 条件映射

插件所映射的键只在特定场景生效，直接在 opts 中映射是全局映射，不能满足需求。
例如只在 sidebar 中生效的键就这么配置

```lua
  {
    "yetone/avante.nvim",
    ---@type avante.Config
    opts = {
      mappings = {
        ---@class AvanteConflictMappings
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<F13>",
          reverse_switch_windows = "<F14>",
          remove_file = "d",
          add_file = "@",
          close = { "<Esc>", "q" },
          close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
        },
      },
    },
  },
```

#### 复杂例子

这是融合了以上三种的例子，插件本身提供了映射，又用 `LazySpec.keys` 获取这些映射实现懒加载并添加描述，最后用 `astrocore` 向 `which-key.nvim` 注册映射

```lua
  {
    "echasnovski/mini.surround",
    event = "User AstroFile",
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Surround = "󰑤" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["gs"] = { desc = require("astroui").get_icon("Surround", 1, true) .. "Surround" }
        end,
      },
    },
    keys = function(plugin, keys)
      -- local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false) -- resolve mini.clue options
      -- Populate the keys based on the user's options
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = function()
      local ts_input = require("mini.surround").gen_spec.input.treesitter
      return {
        n_lines = 50,
        mappings = {
          add = "gsa", -- Add surrounding in Normal modes
          delete = "gsd", -- Delete surrounding
          find = "gsf", -- Find surrounding (to the right)
          find_left = "gsF", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          replace = "gsc", -- Replace surrounding
          update_n_lines = "gsn", -- Update `n_lines`
        },
        custom_surroundings = {
          f = {
            input = ts_input { outer = "@call.outer", inner = "@call.inner" },
          },
        },
      }
    end,
  },
```

### 原生方式 `vim.keymap.set`

```lua

--- @class vim.api.keyset.keymap
--- @field noremap? boolean
--- @field nowait? boolean
--- @field silent? boolean
--- @field script? boolean
--- @field expr? boolean
--- @field unique? boolean
--- @field callback? function
--- @field desc? string
--- @field replace_keycodes? boolean

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
---
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
---
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
function keymap.set(mode, lhs, rhs, opts) end
```

![Nothing stops this train](../assets/2025-09-02-23-52-42.png)
