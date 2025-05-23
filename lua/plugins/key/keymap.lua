-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts) -- Configure core features of AstroNvim
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      local maps = assert(opts.mappings)
      local astro = require "astrocore"

      --- App
      maps.n["<Leader>a"] = { desc = "Appalication" }
      -- maps.n["<Leader>al"] = {
      --   function() require("mason.ui").open() end,
      --   desc = "Mason Installer",
      -- }
      maps.n["<Leader>ax"] = { function() require("lazy").home() end, desc = "Plugins" }
      -- maps.n["<Leader>ae"] = { "<Leader>e", remap = true, desc = "explorer" }

      -- buffers
      maps.n["<Leader>bq"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" }
      maps.n["<Leader>bd"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" }
      maps.n["<Leader>bx"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" }
      maps.n["<Leader>bo"] =
        { function() require("astrocore.buffer").close_all(true) end, desc = "Close all buffers except current" }
      maps.n["<Leader>bC"] = { function() require("astrocore.buffer").close_all() end, desc = "Close all buffers" }
      maps.n["<Leader>bH"] =
        { function() require("astrocore.buffer").close_left() end, desc = "Close all buffers to the left" }
      maps.n["<Leader>bl"] = false
      maps.n["<Leader>br"] = false
      maps.n["<C-T>"] = { function() require("astrocore.buffer").prev() end, desc = "Previous buffer" }
      maps.n["<Leader>bL"] =
        { function() require("astrocore.buffer").close_right() end, desc = "Close all buffers to the right" }

      -- Session/Project
      maps.n["<Leader>p"] = { desc = require("astroui").get_icon("Session", 1, true) .. "Project/Plugin" }
      maps.n["<Leader>pa"] = { function() require("astrocore").update_packages() end, desc = "Update Lazy and Mason" }

      -- search
      -- maps.n["<Leader>s"] = { desc = "Search" }
      -- maps.n["<Leader>fw"] = false
      -- maps.n["<Leader>;"] = { "gc", remap = true, desc = "Toggle comment" }
      -- maps.n["<Leader>;;"] = { "gcc", remap = true, desc = "Toggle comment line" }
      -- maps.x["<Leader>;"] = { "gc", remap = true, desc = "Toggle comment" }

      -- terminal
      maps.t["<A-[>"] = { "<C-\\><C-n>", desc = "enter terminal buffer normal mode" }
      local modes = { "n", "i", "t" }
      for _, mode in ipairs(modes) do
        maps[mode]["<M-t>"] = "<Cmd>ToggleTerm<CR>"
      end

      maps.t["<C-H>"] = false
      maps.t["<C-J>"] = false
      maps.t["<C-K>"] = false
      maps.t["<C-L>"] = false

      maps.n["<S-CR>"] = {
        function()
          local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
          local line = vim.api.nvim_win_get_cursor(0)[1]
          vim.api.nvim_buf_set_lines(0, line - 1, line - 1, true, repeated)
        end,
        desc = "Insert empty line below",
      }

      maps.n["<CR>"] = {
        function()
          local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
          local line = vim.api.nvim_win_get_cursor(0)[1]
          vim.api.nvim_buf_set_lines(0, line, line, true, repeated)
        end,
        desc = "Insert empty line below",
      }

      maps.n["<Leader>qq"] = maps.n["<Leader>Q"]

      -- maps.n["h"] = {
      --   function()
      --     local onIndentOrFirstNonBlank = vim.fn.virtcol "." <= vim.fn.indent "." + 1
      --     local shouldCloseFold = vim.tbl_contains(vim.opt_local.foldopen:get(), "hor")
      --     if onIndentOrFirstNonBlank and shouldCloseFold then
      --       local wasFolded = pcall(function() vim.cmd "silent! foldclose" end)
      --       if wasFolded then return end
      --     end
      --     vim.cmd.normal { "h", bang = true }
      --   end,
      --   desc = "h (+ close fold at BoL)",
      -- }

      -- tabs
      maps.n["<Leader><tab>o"] = { "<cmd>tabonly<cr>", desc = "Close Other Tabs" }
      maps.n["<Leader><tab><tab>"] = { "<cmd>tabnew<cr>", desc = "New Tab" }
      maps.n["<Leader><tab>]"] = { "<cmd>tabnext<cr>", desc = "Next Tab" }
      maps.n["<Leader><tab>d"] = { "<cmd>tabclose<cr>", desc = "Close Tab" }
      maps.n["<Leader><tab>["] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" }
      -- for i = 0, 6 do
      --   maps.n["<Leader><tab>" .. i] = { "<cmd>tabnext " .. i .. "<cr>" }
      -- end
      maps.n["g<Tab>"] = "gt"
      maps.n["<Leader>qr"] = { "<Cmd>AstroReload<cr>" }

      maps.n["gh"] = "K"
      maps.v["gh"] = "K"

      local mini_path = vim.fn.stdpath "config" .. "/lua/utils/basic.vimrc"
      pcall(vim.cmd.source, mini_path)
      -- vim.cmd.source(mini_path)

      -- maps.n["<C-u>"] = { "<C-u>zz", remap = false }
      -- maps.v["<C-u>"] = { "<C-u>zz", remap = false }
      -- maps.n["<C-d>"] = { "<C-d>zz", remap = false }
      -- maps.v["<C-d>"] = { "<C-d>zz", remap = false }
      for _, mode in ipairs { "n", "v", "i", "t" } do
        maps[mode]["<A-q>"] = { "<Cmd>wincmd q<CR>" }
      end
      maps.n["<C-e>"] = "3<C-e>"
      maps.v["<C-e>"] = "3<C-e>"
      -- maps.i["<C-e>"] = { "<C-\\><C-n>:normal! <C-e><CR>a", noremap = true }
      -- maps.i["<C-e>"] = "<C-o>3<C-e>"
      maps.n["<C-y>"] = "3<C-y>"
      maps.v["<C-y>"] = "3<C-y>"
      -- maps.i["<C-y>"] = { "<C-\\><C-n><Cmd>normal! <C-y><CR>a", noremap = true }
      -- maps.i["<C-y>"] = "<C-o>3<C-y>"
      -- maps.n[";"] = { ":", remap = true }
      maps.i["jk"] = false
      maps.i["jj"] = false
      maps.n["n"] = "nzz"
      maps.v["n"] = "nzz"
      maps.n["N"] = "Nzz"
      maps.v["N"] = "Nzz"

      -- local lazygit = {
      --   callback = function()
      --     local worktree = astro.file_worktree()
      --     local default_config = vim.env.HOME .. "/.config/lazygit/config.yml"
      --     local extra_user_config = vim.fn.stdpath "config" .. "/lua/plugins/other/lazygit.yml"
      --     local worktree_flags = worktree and ("--work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
      --       or ""
      --     local flags = ("-ucf=%s,%s %s"):format(default_config, extra_user_config, worktree_flags)
      --     -- vim.notify("lazygit " .. flags)
      --     astro.toggle_term_cmd { cmd = "lazygit " .. flags, direction = "float" }
      --   end,
      --   desc = "ToggleTerm lazygit",
      -- }
      -- maps.n["<Leader>gg"] = { lazygit.callback, desc = lazygit.desc }
      -- maps.n["<Leader>tl"] = { lazygit.callback, desc = lazygit.desc }
      maps.i["<C-Space>"] = "<c-x><c-o>"
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      -- lsp
      maps.n["gR"] = { function() vim.lsp.buf.references() end, desc = "LSP references" }

      maps.n["gh"] = { function() vim.lsp.buf.hover() end, desc = "Lsp Hover" }
      -- maps.n["<Leader>k"] = {
      --   function() vim.lsp.buf.hover() end,
      --   desc = "hover",
      -- }
    end,
  },
}
