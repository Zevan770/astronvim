-- if true then return {} end
---@type LazySpec
return {
  {
    "calebfroese/fzf-lua-zoxide",
    dependencies = { "ibhagwan/fzf-lua" },
    config = function() require("fzf-lua-zoxide").setup() end,
    keys = {
      {
        "<leader>Fz",
        function()
          require("fzf-lua-zoxide").open {
            ---@field preview? string The command to run in the preview window
            preview = "less -R {}",
            ---@field callback? fun(selected: string) Callback to run on select
            callback = function(selected)
              -- For example, you could open the directory in netrw after selecting one
              -- vim.cmd("e " .. selected)
            end,
          }
        end,
        mode = "n",
        desc = "Fzf Dirs",
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    specs = {
      -- { "nvim-telescope/telescope.nvim", optional = true, enabled = false },
      -- { "nvim-telescope/telescope-fzf-native.nvim", optional = true, enabled = false },
      {
        "AstroNvim/astrolsp",
        optional = true,
        opts = function(_, opts)
          if require("astrocore").is_available "fzf-lua" then
            local maps = opts.mappings
            maps.n["<Leader>FlD"] =
              { function() require("fzf-lua").diagnostics_document() end, desc = "Search diagnostics" }
            -- if maps.n.gd then maps.n.gd[1] = function() require("fzf-lua").lsp_definitions() end end
            if maps.n.gI then maps.n.gI[1] = function() require("fzf-lua").lsp_implementations() end end
            if maps.n["<Leader>FlR"] then
              maps.n["<Leader>FlR"][1] = function() require("fzf-lua").lsp_references() end
            end
            if maps.n.gy then maps.n.gy[1] = function() require("fzf-lua").lsp_typedefs() end end
            if maps.n["<Leader>FlG"] then
              maps.n["<Leader>FlG"][1] = function() require("fzf-lua").lsp_workspace_symbols() end
            end
          end
        end,
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>F"] = vim.tbl_get(opts, "_map_sections", "f")
          if vim.fn.executable "git" == 1 then
            maps.n["<Leader>Fg"] = vim.tbl_get(opts, "_map_sections", "g")
            maps.n["<Leader>Fgb"] = { function() require("fzf-lua").git_branches() end, desc = "Git branches" }
            maps.n["<Leader>Fgc"] =
              { function() require("fzf-lua").git_commits() end, desc = "Git commits (repository)" }
            maps.n["<Leader>FgC"] =
              { function() require("fzf-lua").git_bcommits() end, desc = "Git commits (current file)" }
            maps.n["<Leader>Fgt"] = { function() require("fzf-lua").git_status() end, desc = "Git status" }
          end
          maps.n["<Leader>F<CR>"] = { function() require("fzf-lua").resume() end, desc = "Resume previous search" }
          maps.n["<Leader>F'"] = { function() require("fzf-lua").marks() end, desc = "Find marks" }
          maps.n["<Leader>F/"] =
            { function() require("fzf-lua").lgrep_curbuf() end, desc = "Find words in current buffer" }
          maps.n["<Leader>Fa"] = {
            function() require("fzf-lua").files { prompt = "Config> ", cwd = vim.fn.stdpath "config" } end,
            desc = "Find AstroNvim config files",
          }
          maps.n["<Leader>Fb"] = { function() require("fzf-lua").buffers() end, desc = "Find buffers" }
          maps.n["<Leader>Fc"] = { function() require("fzf-lua").grep_cword() end, desc = "Find word under cursor" }
          maps.n["<Leader>FC"] = { function() require("fzf-lua").commands() end, desc = "Find commands" }
          maps.n["<Leader>Ff"] = { function() require("fzf-lua").files() end, desc = "Find files" }
          -- maps.n["<Leader>Fh"] = { function() require("fzf-lua").helptags() end, desc = "Find help" }
          maps.n["<Leader>Fk"] = { function() require("fzf-lua").keymaps() end, desc = "Find keymaps" }
          maps.n["<Leader>Fm"] = { function() require("fzf-lua").manpages() end, desc = "Find man" }
          maps.n["<Leader>Fo"] = { function() require("fzf-lua").oldfiles() end, desc = "Find history" }
          maps.n["<Leader>Fr"] = { function() require("fzf-lua").oldfiles() end, desc = "Find recent files" }
          maps.n["<Leader>FR"] = { function() require("fzf-lua").registers() end, desc = "Find registers" }
          maps.n["<Leader>Ft"] = { function() require("fzf-lua").colorschemes() end, desc = "Find themes" }
          if vim.fn.executable "rg" == 1 or vim.fn.executable "grep" == 1 then
            maps.n["<Leader>Fw"] = { function() require("fzf-lua").live_grep_native() end, desc = "Find words" }
          end
          maps.n["<Leader>Fls"] = { function() require("fzf-lua").lsp_document_symbols() end, desc = "Search symbols" }
          -- maps.c["<C-G>"] = {
          --   function()
          --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "n", true)
          --     require("fzf-lua").command_history { cmd = vim.fn.getreg ":" }
          --   end,
          --   desc = "command_history",
          -- }
        end,
      },
    },
    opts = {
      { "hide", "ivy" },
      winopts = {
        fullscreen = true,
        preview = {
          layout = "vertical",
          vertical = "up:70%",
          border = "none",
        },
      },
    },
  },
}
