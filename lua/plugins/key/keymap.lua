-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts) -- Configure core features of AstroNvim
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      local maps = assert(opts.mappings)
      -- navigate buffer tabs with `H` and `L`
      -- L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
      -- H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

      --- App
      maps.n["<Leader>a"] = { desc = "Appalication" }
      maps.n["<Leader>am"] = {
        function() require("mason.ui").open() end,
        desc = "Mason Installer",
      }
      maps.n["<Leader>ax"] = {
        function() require("lazy").home() end,
        desc = "Plugins",
      }
      -- maps.n["<Leader>ae"] = { "<Leader>e", remap = true, desc = "explorer" }

      -- buffers
      maps.n["<Leader>bq"] = {
        function() require("astrocore.buffer").close() end,
        desc = "Close buffer",
      }
      maps.n["<Leader>bd"] = {
        function() require("astrocore.buffer").close() end,
        desc = "Close buffer",
      }
      maps.n["<Leader>bx"] = {
        function() require("astrocore.buffer").close(0, true) end,
        desc = "Force close buffer",
      }
      maps.n["<Leader>bo"] = {
        function() require("astrocore.buffer").close_all(true) end,
        desc = "Close all buffers except current",
      }
      maps.n["<Leader>bC"] = {
        function() require("astrocore.buffer").close_all() end,
        desc = "Close all buffers",
      }
      maps.n["<Leader>bH"] = {
        function() require("astrocore.buffer").close_left() end,
        desc = "Close all buffers to the left",
      }
      maps.n["<Leader>bl"] = false
      maps.n["<Leader>br"] = false
      maps.n["<Leader><Tab>"] = {
        function() require("astrocore.buffer").prev() end,
        desc = "Previous buffer",
      }
      maps.n["<Leader>bL"] = {
        function() require("astrocore.buffer").close_right() end,
        desc = "Close all buffers to the right",
      }
      maps.n["<Leader>bse"] = {
        function() require("astrocore.buffer").sort "extension" end,
        desc = "By extension",
      }
      maps.n["<Leader>bsr"] = {
        function() require("astrocore.buffer").sort "unique_path" end,
        desc = "By relative path",
      }
      maps.n["<Leader>bsp"] = {
        function() require("astrocore.buffer").sort "full_path" end,
        desc = "By full path",
      }
      maps.n["<Leader>bsi"] = {
        function() require("astrocore.buffer").sort "bufnr" end,
        desc = "By buffer number",
      }
      maps.n["<Leader>bsm"] = {
        function() require("astrocore.buffer").sort "modified" end,
        desc = "By modification",
      }

      -- Session/Project
      maps.n["<Leader>p"] = { desc = require("astroui").get_icon("Session", 1, true) .. "Project/Plugin" }
      maps.n["<Leader>pa"] = {
        function() require("astrocore").update_packages() end,
        desc = "Update Lazy and Mason",
      }
      maps.n["<Leader>S"] = false
      maps.n["<Leader>pl"] = {
        function() require("resession").load "Last Session" end,
        desc = "Load last session",
      }
      maps.n["<Leader>ps"] = {
        function() require("resession").save() end,
        desc = "Save this session",
      }
      maps.n["<Leader>pS"] = {
        function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
        desc = "Save this dirsession",
      }
      maps.n["<Leader>pt"] = {
        function() require("resession").save_tab() end,
        desc = "Save this tab's session",
      }
      maps.n["<Leader>pd"] = {
        function() require("resession").delete() end,
        desc = "Delete a session",
      }
      maps.n["<Leader>pD"] = {
        function() require("resession").delete(nil, { dir = "dirsession" }) end,
        desc = "Delete a dirsession",
      }
      maps.n["<Leader>po"] = {
        function() require("resession").load() end,
        desc = "Load a session",
      }
      maps.n["<Leader>pp"] = {
        function() require("resession").load(nil, { dir = "dirsession" }) end,
        desc = "Load a dirsession",
      }
      maps.n["<Leader>pc"] = {
        function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
        desc = "Load current dirsession",
      }

      -- search
      -- maps.n["<Leader>s"] = { desc = "Search" }
      -- maps.n["<Leader>fw"] = false
      -- maps.n["<Leader>;"] = { "gc", remap = true, desc = "Toggle comment" }
      -- maps.n["<Leader>;;"] = { "gcc", remap = true, desc = "Toggle comment line" }
      -- maps.x["<Leader>;"] = { "gc", remap = true, desc = "Toggle comment" }

      -- terminal
      maps.t["<A-[>"] = { "<C-\\><C-n>", desc = "enter terminal buffer normal mode" }
      maps.n["<A-t>"] = "<Cmd>ToggleTerm<CR>"
      maps.i["<A-t>"] = maps.n["<A-t>"]
      maps.t["<A-t>"] = maps.n["<A-t>"]

      maps.t["<C-H>"] = false
      maps.t["<C-J>"] = false
      maps.t["<C-K>"] = false
      maps.t["<C-L>"] = false

      maps.n["[<Space>"] = {
        function()
          local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
          local line = vim.api.nvim_win_get_cursor(0)[1]
          vim.api.nvim_buf_set_lines(0, line - 1, line - 1, true, repeated)
        end,
        desc = "Insert empty line below",
      }

      maps.n["]<Space>"] = {
        function()
          local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
          local line = vim.api.nvim_win_get_cursor(0)[1]
          vim.api.nvim_buf_set_lines(0, line, line, true, repeated)
        end,
        desc = "Insert empty line below",
      }

      maps.n["h"] = {
        function()
          local onIndentOrFirstNonBlank = vim.fn.virtcol "." <= vim.fn.indent "." + 1
          local shouldCloseFold = vim.tbl_contains(vim.opt_local.foldopen:get(), "hor")
          if onIndentOrFirstNonBlank and shouldCloseFold then
            local wasFolded = pcall(function() vim.cmd "silent! foldclose" end)
            if wasFolded then return end
          end
          vim.cmd.normal { "h", bang = true }
        end,
        desc = "h (+ close fold at BoL)",
      }
      maps.n["<Leader>k"] = function() vim.cmd "normal! K" end
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      -- lsp
      maps.n["gR"] = {
        function() vim.lsp.buf.references() end,
        desc = "LSP references",
      }
      maps.n["<Leader>k"] = {
        function() vim.lsp.buf.hover() end,
        desc = "hover",
      }
    end,
  },
}
