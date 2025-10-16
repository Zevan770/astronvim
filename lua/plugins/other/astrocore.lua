---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    return require("lazy.util").merge(opts, {
      -- Configure core features of AstroNvim
      features = {
        large_buf = { notify = true, size = 1.5 * 1024 * 1024, lines = 100000, line_length = 1000 },
        autopairs = true, -- enable autopairs at start
        cmp = true, -- enable completion at start
        diagnostics = true,
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
          -- inccommand = "split",
          colorcolumn = { 80, 100 },
          completeopt = require("astrocore").list_insert_unique(opts.options.opt.completeopt, { "fuzzy", "preview" }),
          confirm = true,
          diffopt = vim.opt.diffopt + "vertical", -- sets vim.opt.diffopt
          exrc = true,
          foldmarker = "#region,#endregion",
          guicursor = vim.opt.guicursor, -- sets vim.opt.guicursor
          jumpoptions = "view",
          list = true,
          listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:  " }, ","),
          mousemoveevent = true,
          number = true, -- sets vim.opt.number
          pumblend = 10,
          pumheight = 10,
          relativenumber = true, -- sets vim.opt.relativenumber
          sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
          signcolumn = "yes", -- sets vim.opt.signcolumn to auto
          spell = false, -- sets vim.opt.spell
          spelllang = "en,cjk",
          startofline = true,
          splitkeep = "screen",
          sidescrolloff = 8,
          smoothscroll = true,
          wildmode = "list:longest,full",
          wildoptions = "fuzzy,pum,tagfile",
          winblend = 10,
          winborder = "rounded",
          wrap = false, -- sets vim.opt.wrap
          fillchars = "",
          -- fillchars = {
          --   eob = " ",
          --   fold = "╌",
          --   horiz = "═",
          --   horizdown = "╦",
          --   horizup = "╩",
          --   vert = "║",
          --   verthoriz = "╬",
          --   vertleft = "╣",
          --   vertright = "╠",
          -- },
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
        auto_check_bg = vim.fn.has "nvim-0.12" == 1 and {
          {
            event = { "FocusGained", "FocusLost" },
            pattern = "*",
            callback = function()
              -- will query the terminal for background color
              -- Note that we have `:autocmds nvim.tty TermResonse` in _defualt.lua
              vim.schedule(function() vim.api.nvim_ui_send "\027]11;?\007" end)
            end,
          },
        },
      },
      filetypes = {
        extension = {
          foo = "fooscript",
          ahk2 = "autohotkey",
          ahk1 = "autohotkey",
          ah2 = "autohotkey",
          log = "log",
          kbd = "lisp",
        },
        filename = {
          -- [".zshrc"] = "bash",
          ["Foofile"] = "fooscript",
          ["%.vindrc"] = "vim",
          ["messages"] = "log",
          ["tmux.conf"] = "sh",
          [".tmux.conf"] = "sh",
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
      sessions = {
        ignore = {
          dirs = {},
          filetypes = { "gitcommit", "gitrebase" },
          buftypes = {},
        },
      },
    } --[[@as AstroCoreOpts]])
  end,
}
