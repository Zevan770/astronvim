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
      -- vim.keymap.set("i", "<Tab>", "<Tab>")
      --- App

      maps.n["zS"] = "<Cmd>Inspect<CR>"
      maps.n["<Leader>o"] = { desc = "Open Appalication" }
      maps.n["<Leader>ox"] = { function() require("lazy").home() end, desc = "Plugins" }
      -- maps.n["<Leader>oe"] = { "<Leader>e", remap = true, desc = "explorer" }

      -- buffers
      maps.n["<Leader>bd"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" }
      maps.n["H"] = maps.n["[b"]
      maps.n["L"] = maps.n["]b"]
      maps.n["<Leader>bq"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" }
      maps.n["<Leader>bo"] =
        { function() require("astrocore.buffer").close_all(true) end, desc = "Close all buffers except current" }
      maps.n["<Leader>bxa"] = { function() require("astrocore.buffer").close_all() end, desc = "Close all buffers" }
      maps.n["<Leader>bxh"] =
        { function() require("astrocore.buffer").close_left() end, desc = "Close all buffers to the left" }
      maps.n["<C-T>"] = { function() require("astrocore.buffer").prev() end, desc = "Previous buffer" }
      maps.n["<Leader>bxl"] =
        { function() require("astrocore.buffer").close_right() end, desc = "Close all buffers to the right" }
      maps.n["<Leader>bl"] = false
      maps.n["<Leader>br"] = false

      maps.n["|"] = false
      maps.n["\\"] = false

      -- Session/Project
      maps.n["<Leader>p"] = { desc = require("astroui").get_icon("Session", 1, true) .. "Project/Plugin" }
      maps.n["<Leader>pa"] = { function() require("astrocore").update_packages() end, desc = "Update Lazy and Mason" }

      -- terminal
      maps.t["<A-[>"] = { "<C-\\><C-n>", desc = "enter terminal buffer normal mode" }
      local modes = { "n", "t" }
      for _, mode in ipairs(modes) do
        maps[mode]["<M-t>"] = { function() return "<Cmd>" .. vim.v.count .. "ToggleTerm<CR>" end, expr = true }
      end

      -- maps.n["<Leader>t"] = { function() return "<Cmd>ToggleTerm<CR>" end, expr = true }
      maps.t["<C-H>"] = false
      maps.t["<C-J>"] = false
      maps.t["<C-K>"] = false
      maps.t["<C-L>"] = false
      maps.n["<C-Up>"] = false
      maps.n["<C-Down>"] = false
      maps.n["<C-Left>"] = false
      maps.n["<C-Right>"] = false

      maps.n["<Leader>ik"] = {
        function()
          local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
          local line = vim.api.nvim_win_get_cursor(0)[1]
          vim.api.nvim_buf_set_lines(0, line - 1, line - 1, true, repeated)
        end,
        desc = "Insert empty line below",
      }

      maps.n["<Leader>ij"] = {
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
      maps.n["<Leader>hr"] = { "<Cmd>AstroReload<cr><Cmd>AstroReload<CR>" }
      maps.n["<Leader>qr"] = { "<Cmd>restart<cr>" }

      maps.n["<Leader>uB"] = maps.n["<Leader>ub"]
      maps.n["<Leader>ub"] = false

      local mini_path = vim.fn.stdpath "config" .. "/lua/utils/basic.vimrc"
      pcall(vim.cmd.source, mini_path)

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
      maps.n["<esc>"] = {
        function()
          vim.cmd "nohl"
          return "<esc>"
        end,
        expr = true,
        desc = "Escape and Clear hlsearch",
      }

      local esc_timer
      maps.t["<esc>"] = {
        function()
          ---@diagnostic disable-next-line: inject-field
          esc_timer = esc_timer or vim.uv.new_timer()
          if esc_timer:is_active() then
            esc_timer:stop()
            -- vim.api.nvim_feedkeys(vim.keycode "a", "n", false) -- add this line for `--vim`
            vim.cmd "stopinsert"
          else
            esc_timer:start(200, 0, function() end)
            return "<esc>"
          end
        end,
        expr = true,
        desc = "Double escape to normal mode",
      }

      -- maps.n["n"] = "nzz"
      -- maps.v["n"] = "nzz"
      -- maps.n["N"] = "Nzz"
      -- maps.v["N"] = "Nzz"

      if my_utils.is_windows then
        maps.n["<Leader>gg"] = { function() astro.toggle_term_cmd { cmd = "gitui", direction = "float" } end }
        maps.n["<Leader>tl"] = maps.n["<Leader>gg"]
      end

      maps.i["<C-Space>"] = "<c-x><c-o>"

      maps.n["gcp"] = { [["xyygcc"xp]], desc = "comment and duplicate line", remap = true }

      maps.n["h"] = { require("utils.folding").h, desc = "h (+ close fold at BoL)" }
      maps.n["gh"] = { require("utils.folding").gh, desc = "gh (+ close fold at BoL)" }
      maps.n["l"] = { require("utils.folding").l, desc = "l (+ open fold at folding)" }
      maps.n["gl"] = { require("utils.folding").gl, desc = "gl (+ open fold at folding)" }

      maps.c["<A-w>"] = { require("utils.search").toggle_word_boundary, desc = "Match Whole Word" }
      maps.c["<A-c>"] = { require("utils.search").toggle_case_sensitive, desc = "Match Case" }
      maps.c["<A-v>"] = { require("utils.search").toggle_very_magic, desc = "Toggle Very Magic" }

      maps.n["dy"] = "do"

      maps.n["q"] = { function() require("utils.macros").play() end, desc = "play last played macro" }
      maps.x["q"] = maps.n["q"]
      maps.n["@"] = { function() require("utils.macros").q() end, desc = "quick macro" }
      maps.x["@"] = maps.n["@"]
      -- maps.n["zr"] = false
      -- maps.n["zm"] = false
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)
      -- lsp
      maps.n["gR"] = { function() vim.lsp.buf.references() end, desc = "LSP references" }

      if not require("astrocore").is_available "hover.nvim" then
        maps.n["gk"] = { function() vim.lsp.buf.hover() end, desc = "Lsp Hover" }
      end

      if my_utils.markdown_render == "markview" then
        maps.n["gk"] = {
          function()
            local window = vim.api.nvim_get_current_win()

            vim.lsp.buf_request(
              0,
              "textDocument/hover",
              vim.lsp.util.make_position_params(window, "utf-8"),
              require("utils.lsp_hover").hover
            )
          end,
        }
      end
    end,
  },
}
