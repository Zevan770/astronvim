---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    return require("lazy.util").merge(opts, {
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
        -- virtual_lines = function() return { current_line = true } end,
      },
      -- vim options can be configured here
      options = {
        opt = { -- vim.opt.<key>
          relativenumber = true, -- sets vim.opt.relativenumber
          number = true, -- sets vim.opt.number
          spell = false, -- sets vim.opt.spell
          signcolumn = "yes", -- sets vim.opt.signcolumn to auto
          wrap = false, -- sets vim.opt.wrap
          guicursor = vim.opt.guicursor, -- sets vim.opt.guicursor
          diffopt = vim.opt.diffopt + "vertical", -- sets vim.opt.diffopt
          mousemoveevent = true,
          startofline = true,
          foldmarker = "#region,#endregion",
          jumpoptions = "view",
          winblend = 10,
          pumblend = 10,
          pumheight = 10,
          confirm = true,
          sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize",
          completeopt = require("astrocore").list_insert_unique(opts.options.opt.completeopt, { "fuzzy", "preview" }),
          wildoptions = "fuzzy,pum,tagfile",
          wildmode = "list:longest,full",
          colorcolumn = { 80, 100 },
          -- inccommand = "split",
          list = true,
          listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:  " }, ","),
          fillchars = table.concat(
            -- Special UI symbols
            {
              "eob: ",
              "fold:╌",
              "horiz:═",
              "horizdown:╦",
              "horizup:╩",
              "vert:║",
              "verthoriz:╬",
              "vertleft:╣",
              "vertright:╠",
            },
            ","
          ),
        },
        g = { -- vim.g.<key>
          -- configure global vim variables (vim.g)
          -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
          -- This can be found in the `lua/lazy_setup.lua` file
        },
      },
      rooter = {
        autochdir = false,
        scope = "tab",
        notify = true,
      },
      on_keys = {
        auto_hlsearch = false,
      },
      autocmds = {
        highlightyank = false,
        -- help_window_right = {
        --   {
        --     event = "BufWinEnter",
        --     pattern = { "*.txt" },
        --     callback = function()
        --       if vim.o.filetype == "help" then vim.cmd.wincmd "L" end
        --     end,
        --     desc = "Help page at right",
        --   },
        -- },
      },
      filetypes = {
        extension = {
          foo = "fooscript",
          ahk2 = "autohotkey",
          ahk1 = "autohotkey",
          log = "log",
          kbd = "lisp",
        },
        filename = {
          -- [".zshrc"] = "bash",
          ["Foofile"] = "fooscript",
          ["%.vindrc"] = "vim",
          ["messages"] = "log",
        },
        pattern = {
          ["~/%.config/foo/.*"] = "fooscript",
          [".*settings.*%.json"] = "jsonc",
          [".*keybindings.*%.json"] = "jsonc",
          [".*neoconf.*%.json"] = "jsonc",
          ["github%.com_*%.txt"] = "markdown",
          ["/var/log/.*"] = "log",
          ["messages%..*"] = "log",
        },
      },
    } --[[@as AstroCoreOpts]])
  end,
}
