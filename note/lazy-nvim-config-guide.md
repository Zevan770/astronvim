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
