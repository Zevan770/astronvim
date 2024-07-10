-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = function(_, opts) -- Configure core features of AstroNvim
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      local maps = assert(opts.mappings)
      -- navigate buffer tabs with `H` and `L`
      -- L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
      -- H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

      maps.n["<Leader>a"] = { desc = "Appalication" }
      maps.n["<Leader>am"] = { function() require("mason.ui").open() end, desc = "Mason Installer" }
      maps.n["<Leader>ax"] = { function() require("lazy").home() end, desc = "Plugins" }
      maps.n["<Leader>ae"] = { "<Leader>e", remap = true, desc = "explorer" }

      -- maps.n["<Leader>c"] = false
      maps.n["<Leader>p"] = { desc = require("astroui").get_icon("Session", 1, true) .. "Project/Plugin" }
      maps.n["<Leader>pa"] = { function() require("astrocore").update_packages() end, desc = "Update Lazy and Mason" }

      -- Session/Project
      maps.n["<Leader>S"] = false
      maps.n["<Leader>pl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
      maps.n["<Leader>ps"] = { function() require("resession").save() end, desc = "Save this session" }
      maps.n["<Leader>pS"] = {
        function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
        desc = "Save this dirsession",
      }
      maps.n["<Leader>pt"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" }
      maps.n["<Leader>pd"] = { function() require("resession").delete() end, desc = "Delete a session" }
      maps.n["<Leader>pD"] = {
        function() require("resession").delete(nil, { dir = "dirsession" }) end,
        desc = "Delete a dirsession",
      }
      maps.n["<Leader>pL"] = { function() require("resession").load() end, desc = "Load a session" }
      maps.n["<Leader>pp"] =
        { function() require("resession").load(nil, { dir = "dirsession" }) end, desc = "Load a dirsession" }
      maps.n["<Leader>p."] = {
        function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
        desc = "Load current dirsession",
      }
      maps.n["<C-p>"] = { function() require("telescope.builtin").find_files() end, desc = "Find files in Project" }
      maps.n["<Leader>pf"] =
        { function() require("telescope.builtin").find_files() end, desc = "Find files in Project" }
      maps.n["<Leader>pF"] = {
        function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
        desc = "Find all files",
      }

      --file
      maps.n["<Leader>ff"] = { "<Cmd>Telescope file_browser<CR>", desc = "Open File browser" }
      maps.n["<Leader>fr"] = { function() require("telescope.builtin").oldfiles() end, desc = "File recent" }
      maps.n["<Leader>fR"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }

      -- search
      maps.n["<Leader>fw"] = false
      maps.n["<Leader>fo"] = false
      maps.n["<Leader>s"] = { desc = "Search" }
      maps.n["<Leader>sP"] =
        { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" }
      if vim.fn.executable "rg" == 1 then
        maps.n["<Leader>sp"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
        maps.n["<Leader>s."] = {
          function()
            require("telescope.builtin").live_grep {
              additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
            }
          end,
          desc = "Find words in all files",
        }
      end

      -- buffers
      maps.n["<Leader>bq"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" }
      maps.n["<Leader>bd"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" }
      maps.n["<Leader>bx"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" }
      maps.n["<Leader>bD"] =
        { function() require("astrocore.buffer").close_all(true) end, desc = "Close all buffers except current" }
      maps.n["<Leader>bC"] = { function() require("astrocore.buffer").close_all() end, desc = "Close all buffers" }
      maps.n["<Leader>bH"] =
        { function() require("astrocore.buffer").close_left() end, desc = "Close all buffers to the left" }
      maps.n["<Leader><Tab>"] = { function() require("astrocore.buffer").prev() end, desc = "Previous buffer" }
      maps.n["<Leader>bL"] =
        { function() require("astrocore.buffer").close_right() end, desc = "Close all buffers to the right" }
      maps.n["<Leader>bse"] = { function() require("astrocore.buffer").sort "extension" end, desc = "By extension" }
      maps.n["<Leader>bsr"] =
        { function() require("astrocore.buffer").sort "unique_path" end, desc = "By relative path" }
      maps.n["<Leader>bsp"] = { function() require("astrocore.buffer").sort "full_path" end, desc = "By full path" }
      maps.n["<Leader>bsi"] = { function() require("astrocore.buffer").sort "bufnr" end, desc = "By buffer number" }
      maps.n["<Leader>bsm"] = { function() require("astrocore.buffer").sort "modified" end, desc = "By modification" }

      -- commands and keymaps
      maps.n["<Leader>?"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
      maps.n["<Leader><Leader>"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }

      maps.n["<Leader>;"] = { "gc", remap = true, desc = "Toggle comment" }
      maps.n["<Leader>;;"] = { "gcc", remap = true, desc = "Toggle comment line" }
      maps.x["<Leader>;"] = { "gc", remap = true, desc = "Toggle comment" }

      -- lsp
      maps.n["gr"] = { function() require("telescope.builtin").lsp_references() end, desc = "LSP references" }
      maps.n["gh"] = { function() vim.lsp.buf.hover() end, desc = "hover" }
      -- tables with just a `desc` key will be registered with which-key if it's installed
      -- this is useful for naming menus
      -- ["<Leader>b"] = { desc = "Buffers" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    end,
  },
}
