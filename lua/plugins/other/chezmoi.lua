if my_utils.is_windows then return {} end
---@type LazySpec
return {
  {
    "alker0/chezmoi.vim",
    lazy = false,
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              ["chezmoi#use_tmp_buffer"] = 1,
              ["chezmoi#source_dir_path"] = os.getenv "HOME" .. "/.local/share/chezmoi",
            },
          },
        },
      },
    },
  },
  {
    "xvzc/chezmoi.nvim",
    enabled = vim.fn.has "win32" ~= 1,
    opts = {
      edit = {
        watch = false,
        force = false,
      },
      notification = {
        on_open = true,
        on_apply = true,
        on_watch = true,
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          autocmds = {
            chezmoi = {
              {
                event = { "BufRead", "BufNewFile" },
                pattern = { os.getenv "HOME" .. "/.local/share/chezmoi/*" },
                callback = function() vim.schedule(require("chezmoi.commands.__edit").watch) end,
              },
            },
          },
        },
      },
    },
    specs = {
      -- {
      --   "nvim-telescope/telescope.nvim",
      --   optional = true,
      --   dependencies = {
      --     "xvzc/chezmoi.nvim",
      --     {
      --       "AstroNvim/astrocore",
      --       opts = {
      --         mappings = {
      --           n = {
      --             ["<Leader>hc"] = {
      --               function() require("telescope").extensions.chezmoi.find_files() end,
      --               desc = "Find chezmoi config",
      --             },
      --           },
      --         },
      --       },
      --     },
      --   },
      --   opts = function() require("telescope").load_extension "chezmoi" end,
      -- },
      -- {
      --   "ibhagwan/fzf-lua",
      --   optional = true,
      --   dependencies = {
      --     {
      --       "AstroNvim/astrocore",
      --       ---@type AstroCoreOpts
      --       opts = {
      --         commands = {
      --           ChezmoiFzf = {
      --             function()
      --               require("fzf-lua").fzf_exec(require("chezmoi.commands").list(), {
      --                 actions = {
      --                   ["default"] = function(selected, _)
      --                     require("chezmoi.commands").edit {
      --                       targets = { "~/" .. selected[1] },
      --                       args = { "--watch" },
      --                     }
      --                   end,
      --                 },
      --               })
      --             end,
      --             desc = "Search Chezmoi configuration with FZF",
      --           },
      --         },
      --         mappings = {
      --           n = {
      --             ["<Leader>hc"] = {
      --               function() vim.cmd.ChezmoiFzf() end,
      --               desc = "Find chezmoi config",
      --             },
      --           },
      --         },
      --       },
      --     },
      --   },
      -- },
      {
        "folke/snacks.nvim",
        optional = true,
        dependencies = {
          "xvzc/chezmoi.nvim",
          {
            "AstroNvim/astrocore",
            opts = {
              mappings = {
                n = {
                  ["<Leader>hc"] = {
                    function()
                      local results = require("chezmoi.commands").list {
                        args = {
                          "--path-style",
                          "absolute",
                          -- "--include",
                          -- "files",
                          "--exclude",
                          "externals",
                        },
                      }
                      local items = {}

                      for _, czFile in ipairs(results) do
                        table.insert(items, {
                          text = czFile,
                          file = czFile,
                        })
                      end

                      ---@type snacks.picker.Config
                      local opts = {
                        items = items,
                        confirm = function(picker, item)
                          picker:close()
                          require("chezmoi.commands").edit {
                            targets = { item.text },
                            args = { "--watch" },
                          }
                        end,
                      }
                      Snacks.picker.pick(opts)
                    end,
                    desc = "Find chezmoi config",
                  },
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      file = {
        [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
        ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
        ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
      },
    },
  },
}
