-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      -- diagnostics = {
      --   virtual_text = false,
      --   virtual_lines = true,
      -- },
      highlighturl = false, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
      virtual_lines = function() return { current_line = true } end,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        guicursor = vim.opt.guicursor + "n-o:blinkon5", -- sets vim.opt.guicursor
        diffopt = vim.opt.diffopt + "vertical", -- sets vim.opt.diffopt
        mousemoveevent = true,
        startofline = true,
        foldmarker = "#region, #endregion",
        jumpoptions = "view",
        pumblend = 10,
        pumheight = 10,
        confirm = true,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        -- H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
    rooter = {
      autochdir = false,
      notify = false,
    },
    filetypes = {
      extension = {
        foo = "fooscript",
        ahk2 = "autohotkey",
        ahk1 = "autohotkey",
        -- log = "logtalk",
      },
      filename = {
        ["Foofile"] = "fooscript",
        -- see zsh as bash
        ["%.zsh"] = "bash",
        ["%.zshrc"] = "bash",
        ["%.zshenv"] = "bash",
        ["%.zprofile"] = "bash",
        ["%.zlogin"] = "bash",
        ["%.zlogout"] = "bash",
        ["%.vindrc"] = "vim",
        ["mcpservers.json"] = "jsonc",
      },
      pattern = {
        ["~/%.config/foo/.*"] = "fooscript",
        [".*settings.*%.json"] = "jsonc",
        [".*keybindings.*%.json"] = "jsonc",
        [".*neoconf.*%.json"] = "jsonc",
        ["github%.com_*%.txt"] = "markdown",
      },
    },
  },
}
