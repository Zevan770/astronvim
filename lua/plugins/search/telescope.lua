-- if true then return {} end
---@type LazySpec
if vim.fn.has "nvim-0.11" == 1 then return {} end
return {
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  { import = "astrocommunity.utility.telescope-lazy-nvim" },
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

          maps.n["<Leader>fr"] = {
            function() require("telescope").extensions.frecency.frecency {} end,
            desc = "Frecency",
          }
          -- Use a specific workspace tag:
          maps.n["<Leader>ff"] = {
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)

          -- file
          -- maps.n["<Leader>ff"] = { "<Cmd>Telescope file_browser<CR>", desc = "Open File browser" }
          maps.n["<A-b>"] = {
            function() require("telescope.builtin").buffers() end,
            desc = "File recent",
          }
          maps.n["<Leader>fO"] = {
            function() require("telescope.builtin").vim_options() end,
            desc = "Find options",
          }
          maps.n["<leader>fj"] = {
            function() require("telescope.builtin").jumplist() end,
            desc = "jumplist",
          }

          maps.n["<Leader>h"] = { desc = "+Help" }
          maps.n["<Leader>hD"] = {
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
          maps.n["<Leader>hk"] = {
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

          maps.n["<C-p>"] = {
            function() require("telescope.builtin").find_files() end,
            desc = "Find files in Project",
          }
          maps.n["<Leader>pf"] = {
            function() require("telescope.builtin").find_files() end,
            desc = "Find files in Project",
          }
          maps.n["<Leader>pF"] = {
            function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
            desc = "Find all files",
          }
          maps.n["<Leader>sP"] = {
            function() require("telescope.builtin").grep_string() end,
            desc = "Find word under cursor",
          }
          if vim.fn.executable "rg" == 1 then
            maps.n["<Leader>sp"] = {
              function() require("telescope.builtin").live_grep() end,
              desc = "Find words",
            }
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
          maps.n["<Leader>?"] = {
            function() require("telescope.builtin").keymaps() end,
            desc = "Find keymaps",
          }
          -- maps.n["<Leader><Leader>"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }

          maps.n["<Leader>fx"] = {
            "<Cmd>Telescope lazy<CR>",
            desc = "Find commands",
          }
        end,
      },
    },
    specs = {
      {
        "AstroNvim/astrolsp",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          maps.n["<Leader>lg"] = {
            function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
            desc = "LSP symbols",
          }
        end,
      },
      { "stevearc/dressing.nvim", optional = true, opts = { select = { backend = { "telescope" } } } },
    },
    opts = {
      defaults = {
        layout_config = {
          preview_cutoff = 0,
        },
        mappings = {
          i = {
            ["<c-space>"] = function()
              require("telescope.actions.layout").toggle_preview(vim.api.nvim_get_current_buf())
            end,
          },
          n = {
            ["<c-space>"] = function()
              require("telescope.actions.layout").toggle_preview(vim.api.nvim_get_current_buf())
            end,
          },
        },
      },
    },
  },
  {
    "brookhong/telescope-pathogen.nvim",
    lazy = true,
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        opts = function(self, opts)
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
      { "<leader>fpl", "<Cmd>Telescope pathogen live_grep<CR>", silent = true },
      -- { "<leader>fp", "<Cmd>Telescope pathogen<CR>", silent = true },
      { "<leader>fpf", "<Cmd>Telescope pathogen find_files<CR>", silent = true },
      { "<leader>fpg", "<Cmd>Telescope pathogen grep_string<CR>", silent = true },
      { "<leader>fpb", "<Cmd>Telescope pathogen quick_buffer<CR>", silent = true },
    },
  },
}
