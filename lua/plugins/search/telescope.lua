-- if true then return {} end
---@type LazySpec
-- if vim.fn.has "nvim-0.11" == 1 then return {} end
return {
  {
    "nvim-telescope/telescope.nvim",
    specs = {
      { "nvim-lua/plenary.nvim", lazy = true },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local astro = require "astrocore"
          local is_available = astro.is_available
          maps.n["<Leader>ts"] = vim.tbl_get(opts, "_map_sections", "f")
          if vim.fn.executable "git" == 1 then
            maps.n["<Leader>tg"] = vim.tbl_get(opts, "_map_sections", "g")
            maps.n["<Leader>tgb"] = {
              function() require("telescope.builtin").git_branches { use_file_path = true } end,
              desc = "Git branches",
            }
            maps.n["<Leader>tgc"] = {
              function() require("telescope.builtin").git_commits { use_file_path = true } end,
              desc = "Git commits (repository)",
            }
            maps.n["<Leader>tgC"] = {
              function() require("telescope.builtin").git_bcommits { use_file_path = true } end,
              desc = "Git commits (current file)",
            }
            maps.n["<Leader>tgt"] =
              { function() require("telescope.builtin").git_status { use_file_path = true } end, desc = "Git status" }
          end
          maps.n["<Leader>ts<CR>"] =
            { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
          maps.n["<Leader>ts'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
          maps.n["<Leader>ts/"] = {
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            desc = "Find words in current buffer",
          }
          maps.n["<Leader>tsa"] = {
            function()
              require("telescope.builtin").find_files {
                prompt_title = "Config Files",
                cwd = vim.fn.stdpath "config",
              }
            end,
            desc = "Find AstroNvim config files",
          }
          maps.n["<Leader>tsb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
          maps.n["<Leader>tsc"] =
            { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" }
          maps.n["<Leader>tsC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
          maps.n["<Leader>tsf"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
          maps.n["<Leader>tsF"] = {
            function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
            desc = "Find all files",
          }
          maps.n["<Leader>tsg"] = { function() require("telescope.builtin").git_files() end, desc = "Find git files" }
          maps.n["<Leader>tsh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
          maps.n["<Leader>tsk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
          maps.n["<Leader>tsm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
          if is_available "nvim-notify" then
            maps.n["<Leader>tsn"] =
              { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
          end
          maps.n["<Leader>tso"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
          maps.n["<Leader>tsr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
          maps.n["<Leader>tst"] = {
            function() require("telescope.builtin").colorscheme { enable_preview = true, ignore_builtins = true } end,
            desc = "Find themes",
          }
          if vim.fn.executable "rg" == 1 then
            maps.n["<Leader>tsw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
            maps.n["<Leader>tsW"] = {
              function()
                require("telescope.builtin").live_grep {
                  additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
                }
              end,
              desc = "Find words in all files",
            }
          end
          maps.n["<Leader>tlD"] =
            { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" }
          maps.n["<Leader>tls"] = {
            function()
              if is_available "aerial.nvim" then
                require("telescope").extensions.aerial.aerial()
              else
                require("telescope.builtin").lsp_document_symbols()
              end
            end,
            desc = "Search symbols",
          }
          maps.n["<Leader>tlg"] = {
            function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
            desc = "LSP symbols",
          }
          -- file
          -- maps.n["<Leader>tsf"] = { "<Cmd>Telescope file_browser<CR>", desc = "Open File browser" }
          -- maps.n["<A-b>"] = {
          --   function() require("telescope.builtin").buffers() end,
          --   desc = "File recent",
          -- }
          maps.n["<Leader>tsO"] = {
            function() require("telescope.builtin").vim_options() end,
            desc = "Find options",
          }
          maps.n["<leader>tsj"] = {
            function() require("telescope.builtin").jumplist() end,
            desc = "jumplist",
          }

          maps.n["<Leader>tsh"] = { desc = "+Help" }
          maps.n["<Leader>tshD"] = {
            function()
              require("telescope.builtin").find_files {
                prompt_title = "AstroNvim stuffs",
                follow = true,
                search_dirs = {
                  vim.fn.stdpath "data" .. "/lazy/AstroNvim",
                  vim.fn.stdpath "data" .. "/lazy/astrocommunity",
                  vim.fn.stdpath "config",
                },
              }
            end,
            desc = "Astro config files",
          }
          maps.n["<Leader>tshk"] = {
            function()
              require("telescope.builtin").live_grep {
                search_dirs = {
                  vim.fn.stdpath "data" .. "/lazy/AstroNvim",
                  vim.fn.stdpath "data" .. "/lazy/astrocommunity",
                  vim.fn.stdpath "config",
                },
                glob_pattern = { "*.lua" },
              }
            end,
            desc = "Keymaps/Live grep Astro files",
          }

          -- maps.n["<C-p>"] = {
          --   function() require("telescope.builtin").find_files() end,
          --   desc = "Find files in Project",
          -- }
          -- maps.n["<Leader>pf"] = {
          --   function() require("telescope.builtin").find_files() end,
          --   desc = "Find files in Project",
          -- }
          -- maps.n["<Leader>pF"] = {
          --   function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
          --   desc = "Find all files",
          -- }
          -- maps.n["<Leader>sP"] = {
          --   function() require("telescope.builtin").grep_string() end,
          --   desc = "Find word under cursor",
          -- }
          -- if vim.fn.executable "rg" == 1 then
          --   maps.n["<Leader>sp"] = {
          --     function() require("telescope.builtin").live_grep() end,
          --     desc = "Find words",
          --   }
          --   maps.n["<Leader>s."] = {
          --     function()
          --       require("telescope.builtin").live_grep {
          --         additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
          --       }
          --     end,
          --     desc = "Find words in all files",
          --   }
          -- end

          -- commands and keymaps
          maps.n["<Leader>tsk"] = {
            function() require("telescope.builtin").keymaps() end,
            desc = "Find keymaps",
          }
          -- maps.n["<Leader><Leader>"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
        end,
      },
      -- {
      --   "nvim-neo-tree/neo-tree.nvim",
      --   optional = true,
      --   opts = {
      --     commands = {
      --       find_in_dir = function(state)
      --         local node = state.tree:get_node()
      --         local path = node.type == "file" and node:get_parent_id() or node:get_id()
      --         require("telescope.builtin").find_files { cwd = path }
      --       end,
      --     },
      --     window = { mappings = { F = "find_in_dir" } },
      --   },
      -- },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        enabled = vim.fn.executable "make" == 1 or vim.fn.executable "cmake" == 1,
        build = vim.fn.executable "make" == 1 and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        config = function(plugin) -- automatically rebuild if not already built
          local astrocore = require "astrocore"
          astrocore.on_load("telescope.nvim", function()
            local ok, err = pcall(require("telescope").load_extension, "fzf")
            if not ok then
              local lib = plugin.dir .. "/build/libfzf." .. (vim.fn.has "win32" == 1 and "dll" or "so")
              if not vim.uv.fs_stat(lib) then
                astrocore.notify("`telescope-fzf-native.nvim` not built. Rebuilding...", vim.log.levels.WARN)
                require("lazy").build({ plugins = { plugin }, show = false }):wait(
                  function() astrocore.notify "Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim." end
                )
              else
                astrocore.notify("Failed to load `telescope-fzf-native.nvim`:\n" .. err, vim.log.levels.ERROR)
              end
            end
          end)
        end,
      },
    },
    cmd = "Telescope",
    opts = function()
      local actions, get_icon = require "telescope.actions", require("astroui").get_icon
      local function open_selected(prompt_bufnr)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local selected = picker:get_multi_selection()
        if vim.tbl_isempty(selected) then
          actions.select_default(prompt_bufnr)
        else
          actions.close(prompt_bufnr)
          for _, file in pairs(selected) do
            if file.path then vim.cmd("edit" .. (file.lnum and " +" .. file.lnum or "") .. " " .. file.path) end
          end
        end
      end
      local function open_all(prompt_bufnr)
        actions.select_all(prompt_bufnr)
        open_selected(prompt_bufnr)
      end
      return {
        defaults = {
          file_ignore_patterns = { "^%.git[/\\]", "[/\\]%.git[/\\]" },
          git_worktrees = require("astrocore").config.git_worktrees,
          prompt_prefix = get_icon("Selected", 1),
          selection_caret = get_icon("Selected", 1),
          multi_icon = get_icon("Selected", 1),
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            -- preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-J>"] = actions.move_selection_next,
              ["<C-K>"] = actions.move_selection_previous,
              ["<CR>"] = open_selected,
              ["<M-CR>"] = open_all,
              ["<M-n>"] = function() require("telescope.actions.layout").toggle_mirror(vim.api.nvim_get_current_buf()) end,
              ["<M-p>"] = function() require("telescope.actions.layout").toggle_preview(vim.api.nvim_get_current_buf()) end,
            },
            n = {
              q = actions.close,
              ["<CR>"] = open_selected,
              ["<M-CR>"] = open_all,
              ["<M-n>"] = function()
                require("telescope.actions.layout").toggle_prompt_position(vim.api.nvim_get_current_buf())
              end,
              ["M-p"] = function() require("telescope.actions.layout").toggle_preview(vim.api.nvim_get_current_buf()) end,
            },
          },
        },
        pickers = {
          find_files = {
            follow = true,
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      local is_available = require("astrocore").is_available
      if is_available "nvim-notify" then telescope.load_extension "notify" end
      if is_available "aerial.nvim" then telescope.load_extension "aerial" end
    end,
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    enabled = false,
    specs = {
      {
        "nvim-telescope/telescope.nvim",
      },
    },
    config = function() require("telescope").load_extension "frecency" end,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)

          maps.n["<Leader>tsr"] = {
            function() require("telescope").extensions.frecency.frecency {} end,
            desc = "Frecency",
          }
          -- Use a specific workspace tag:
          maps.n["<Leader>tsf"] = {
            function()
              require("telescope").extensions.frecency.frecency {
                workspace = "CWD",
                path_display = { "shorten" },
                theme = "ivy",
              }
            end,
            desc = "Frecency CWD",
          }
        end,
      },
    },
  },

  {
    "brookhong/telescope-pathogen.nvim",
    lazy = true,
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
          require("telescope").load_extension "pathogen"
          -- vim.keymap.set("v", "", require("telescope").extensions["pathogen"].grep_string)
          if not opts.extensions then opts.extensions = {} end
          opts.extensions.pathogen = {
            attach_mappings = function(map, actions)
              map("i", "<C-o>", actions.proceed_with_parent_dir)
              map("i", "<C-l>", actions.revert_back_last_dir)
              map("i", "<C-b>", actions.change_working_directory)
              map("i", "<C-g>g", actions.grep_in_result)
              map("i", "<C-g>i", actions.invert_grep_in_result)
            end,
            -- remove below if you want to enable it
            use_last_search_for_live_grep = false,
            -- quick_buffer_characters = "asdfgqwertzxcvb",
            prompt_prefix_length = 100,
          }
        end,
      },
    },
    keys = {
      { "<leader>tspl", "<Cmd>Telescope pathogen live_grep<CR>", silent = true },
      -- { "<leader>tsp", "<Cmd>Telescope pathogen<CR>", silent = true },
      { "<leader>tspf", "<Cmd>Telescope pathogen find_files<CR>", silent = true },
      { "<leader>tspg", "<Cmd>Telescope pathogen grep_string<CR>", silent = true },
      { "<leader>tspb", "<Cmd>Telescope pathogen quick_buffer<CR>", silent = true },
    },
  },

  {
    "polirritmico/telescope-lazy-plugins.nvim",
    lazy = true,
    enabled = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        { "polirritmico/telescope-lazy-plugins.nvim" },
      },
      opts = function(_, opts) require("telescope").load_extension "lazy_plugins" end,
    },
    keys = {
      { "<leader>tsx", "<Cmd>Telescope lazy_plugins<CR>", silent = true },
    },
  },
  -- { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  {
    "tsakirist/telescope-lazy.nvim",
    lazy = true,
    specs = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "tsakirist/telescope-lazy.nvim" },
        opts = function() require("telescope").load_extension "lazy" end,
      },
    },
    keys = {
      { "<Leader>tsz", "<Cmd>Telescope lazy<CR>", silent = true },
    },
  },
}
