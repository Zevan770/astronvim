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
      maps.n["<Leader>am"] = { function() require("lazy").home() end, desc = "Mason" }
      maps.n["<Leader>ax"] = { function() require("lazy").home() end, desc = "Plugins" }

      maps.n["<Leader>c"] = false
      maps.n["<Leader>p"] = { desc = require("astroui").get_icon("Session", 1, true) .. "Project/Plugin" }
      -- maps.n["<Leader>pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
      -- maps.n["<Leader>ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
      -- maps.n["<Leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
      -- maps.n["<Leader>pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
      -- maps.n["<Leader>pU"] = { function() require("lazy").update() end, desc = "Plugins Update" }
      maps.n["<Leader>pa"] = { function() require("astrocore").update_packages() end, desc = "Update Lazy and Mason" }

      -- Session/Project
      maps.n["<Leader>S"] = false
      maps.n["<Leader>pL"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
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
      maps.n["<Leader>pl"] = { function() require("resession").load() end, desc = "Load a session" }
      maps.n["<Leader>pp"] =
        { function() require("resession").load(nil, { dir = "dirsession" }) end, desc = "Load a dirsession" }
      maps.n["<Leader>p."] = {
        function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
        desc = "Load current dirsession",
      }
      maps.n["<Leader>pf"] =
        { function() require("telescope.builtin").find_files() end, desc = "Find files in Project" }
      maps.n['<Leader>p"'] = {
        function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
        desc = "Find all files",
      }
      maps.n["<Leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }

      --file
      maps.n["<Leader>ff"] = { "<Cmd>Telescope file_browser<CR>", desc = "Open File browser" }
      maps.n["<Leader>fr"] = { function() require("telescope.builtin").oldfiles() end, desc = "File recent" }
      maps.n["<Leader>fR"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }

      -- search
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

      -- commands and keymaps
      maps.n["<Leader>?"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
      maps.n["<Leader><Leader>"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }

      -- tables with just a `desc` key will be registered with which-key if it's installed
      -- this is useful for naming menus
      -- ["<Leader>b"] = { desc = "Buffers" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    end,
  },
}
