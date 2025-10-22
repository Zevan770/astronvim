-- if true then return {} end
---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      image = {
        enabled = not not vim.env.KITTY_PID,
        doc = {
          enabled = not not vim.env.KITTY_PID,
          inline = true,
          -- only_render_image_at_cursor = my_utils.neovim_mode == "skitty" and false or true,
          -- render the image in a floating window
          -- only used if `opts.inline` is disabled
          float = true,
          -- max_width = my_utils.neovim_mode == "kitty" and 5 or 60,
          -- max_height = my_utils.neovim_mode == "kitty" and 2.5 or 30,
          -- max_height = 30,
        },
      },
      input = {
        win = {
          relative = "cursor",
          row = 3,
          col = 0,
        },
        enabled = true,
      },
      notifier = {
        enabled = true,
        top_down = false, -- place notifications from top to bottom
      },
      picker = {
        main = {
          file = false,
        },
        matcher = {
          frecency = true, -- frecency bonus
          history_bonus = true, -- give more weight to chronological order
        },
        auto_close = false,
        win = {
          list = {
            keys = {
              ["o"] = { { "pick_win", "jump" } },
            },
          },
          input = {
            keys = {
              -- every action will always first change the cwd of the current tabpage to the project
              ["o"] = { { "pick_win", "jump" } },
              ["<a-c>"] = { "layout" },
              ["<c-p>"] = { "history_back", mode = { "n", "i" } },
              ["<c-n>"] = { "history_forward", mode = { "n", "i" } },
              ["m"] = "list_scroll_down",
              [","] = "list_scroll_up",
              ["<c-y>"] = {
                "yank_path",
                mode = { "n", "i" },
              },
            },
          },
        },
        actions = {
          yank_path = { action = "yank", field = "_path" },
        },
        previewers = {
          git = { builtin = false },
          diff = { builtin = false },
        },
        layout = {
          preset = function() return vim.o.columns >= 120 and "default" or "ivy_split" end,
        },
      },
      styles = {
        snacks_image = {
          relative = "editor",
          col = -1,
        },
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          local title = "AstroNvim stuffs"
          local astro_dirs = {
            vim.fn.stdpath "data" .. "/lazy/AstroNvim",
            vim.fn.stdpath "data" .. "/lazy/astrocore",
            vim.fn.stdpath "data" .. "/lazy/astrolsp",
            vim.fn.stdpath "data" .. "/lazy/astroui",
            vim.fn.stdpath "data" .. "/lazy/astrocommunity",
            vim.fn.stdpath "config",
          }
          maps.n["<Leader>h"] = { desc = require("astroui").get_icon("Help", 1, true) .. "Help" }
          maps.v["<Leader>h"] = maps.n["<Leader>h"]
          maps.n["<Leader>hg"] = {
            function()
              Snacks.picker.grep {
                dirs = astro_dirs,
                title = title,
                glob = { "*.lua" },
              }
            end,
            desc = "grep" .. title,
          }
          maps.n["<Leader>hs"] = {
            function()
              Snacks.picker.grep {
                dirs = vim.api.nvim_list_runtime_paths(),
                title = title,
                glob = { "*.lua", "*.vim", "*.txt" },
              }
            end,
            desc = "super grep neovim runtime files",
          }
          maps.n["<Leader>hd"] = {
            function()
              Snacks.picker.files {
                dirs = vim.api.nvim_list_runtime_paths(),
                title = title,
              }
            end,
            desc = title,
          }
          maps.n["<Leader>sp"] = maps.n["fw"]
          maps.n["<Leader>/"] = maps.n["fw"]
          maps.n["<Leader>sP"] = maps.n["fc"]
          maps.n["<C-p>"] = maps.n["ff"]
          maps.n["<Leader>pf"] = maps.n["ff"]
          maps.n["fb"] = {
            function()
              Snacks.picker.buffers {
                layout = {
                  preset = "ivy_split",
                  -- preview = "main",
                },
              }
            end,
            desc = maps.n["fb"].desc,
          }
          maps.n["<A-b>"] = maps.n["fb"]
          -- maps.n["<A-x>"] = maps.n["fC"]

          maps.n["fc"] = { function() Snacks.picker.commands() end, desc = "Find Commands" }
          maps.n["fr"] = { function() Snacks.picker.recent() end, desc = "Find Recents" }
          maps.n["fj"] = {
            function() Snacks.picker.jumps { layout = { preset = "vertical", preview = "main" } } end,
            desc = "Find Jumps",
          }
          maps.n["fu"] = { function() Snacks.picker.undo() end, desc = "Find Undo history" }
          maps.n["fx"] = { function() Snacks.picker.lazy() end, desc = "Find lazy eXtension specs" }
          maps.n["fz"] = {
            function()
              Snacks.picker.zoxide {
                win = {
                  input = {
                    keys = {
                      -- every action will always first change the cwd of the current tabpage to the project
                      ["<c-e>"] = { { "tcd", "picker_explorer" }, mode = { "n", "i" } },
                      ["<c-f>"] = { { "tcd", "picker_files" }, mode = { "n", "i" } },
                      ["<c-g>"] = { { "tcd", "picker_grep" }, mode = { "n", "i" } },
                      ["<c-r>"] = { { "tcd", "picker_recent" }, mode = { "n", "i" } },
                      ["<c-t>"] = {
                        function(picker)
                          _G.last_picker = picker
                          vim.cmd "tabnew"
                          picker:action "load_session"
                        end,
                        mode = { "n", "i" },
                      },
                    },
                  },
                },
                confirm = { "tcd", "close" },
              }
            end,
            desc = "Find Zoxide",
          }
          maps.n["<M-z>"] = maps.n["fz"]
          maps.n["f'"] = { function() Snacks.picker.marks { layout = "ivy_split" } end, desc = "Find marks" }
          maps.n['f"'] = { function() Snacks.picker.registers() end, desc = "Find register" }
          maps.n["f;"] = { function() Snacks.picker.command_history() end, desc = "Find Command history" }
          maps.n["f/"] = { function() Snacks.picker.search_history() end, desc = "Find Search history" }

          maps.n["f<Space>"] = { function() Snacks.picker() end, desc = "pick ?" }

          maps.n["fe"] = { function() Snacks.picker.explorer() end, desc = "Snacks treE" }
          maps.c["<C-t>"] = {
            function()
              vim.api.nvim_feedkeys(vim.keycode "<Esc>", "n", true)
              vim.schedule(function()
                Snacks.picker.command_history {
                  config = function(o) o.pattern = vim.fn.getreg ":" end,
                }
              end)
            end,
            desc = "command history",
          }

          maps.n["<Leader>."] = { function() Snacks.scratch() end, desc = "new Scratch buffer" }

          maps.n["fk"][1] = function()
            Snacks.picker.keymaps {
              plugs = true,
            }
          end
          maps.n["fq"] = {
            function() Snacks.picker.qflist { layout = { preset = "ivy_split" } } end,
          }

          maps.n["<Leader>ha"] = maps.n["fa"]
          maps.n["<Leader>hh"] = maps.n["fh"]
          maps.n["<F1>"] = maps.n["fh"]
          maps.n["fh"] = { function() Snacks.picker.highlights() end, desc = "Find Highlights" }
          maps.n["fi"] = { function() Snacks.picker.icons() end, desc = "Find icons" }
          maps.i["<C-x>i"] = { function() Snacks.picker.icons() end, desc = "Find icons" }
          maps.n["fa"] = { function() Snacks.picker.autocmds() end, desc = "Find autocmds" }

          maps.n["<A-/>"] = {
            function()
              Snacks.picker.keymaps {
                global = false,
                -- modes = { vim.api.nvim_get_mode().mode },
                layout = {
                  preset = "dropdown",
                  preview = false,
                },
                ---@type fun(item:snacks.picker.finder.Item, ctx:snacks.picker.finder.ctx):(boolean|snacks.picker.finder.Item|nil)
                transform = function(item, ctx)
                  local km = item.item ---@type vim.api.keyset.get_keymap
                  if not km.desc then return true end
                  if
                    km.desc:match "^which%-key%-trigger"
                    or km.desc:match "^Next"
                    or km.desc:match "^Previous"
                    or km.desc:match "^Swap"
                  then
                    return false
                  end
                  return true
                end,
              }
            end,
            desc = "Find keymaps",
          }
          maps.x["<A-/>"] = maps.n["<A-/>"]
          maps.i["<A-/>"] = maps.n["<A-/>"]

          maps.n["<Leader>op"] = { function() Snacks.profiler.scratch() end, desc = "Profiler" }
          require("snacks").toggle.zoom():map("<C-w>z"):map("<a-m>", { mode = { "n", "x", "i", "t" } })

          maps.n["<Leader>lg"] = {
            function() require("snacks").picker.lsp_workspace_symbols() end,
            desc = "Search workspace symbols",
          }

          maps.n["<Leader>ls"] = {
            function()
              ---@type snacks.picker.Config
              local snacks_opts = {
                layout = {
                  preset = "sidebar",
                  layout = {
                    position = "right",
                  },
                },
              }
              local aerial_avail, aerial = pcall(require, "aerial")
              if aerial_avail and aerial.snacks_picker then
                aerial.snacks_picker(snacks_opts)
              else
                require("snacks").picker.lsp_symbols(snacks_opts)
              end
            end,
            desc = "Search symbols",
          }
          maps.n["<A-o>"] = maps.n["<Leader>ls"]
        end,
      },
    },
  },

  -- configure dashboard
  {
    "folke/snacks.nvim",
    ---@param opts snacks.Config
    opts = function(_, opts)
      local get_icon = require("astroui").get_icon

      -- local buaa_logo_section
      -- local buaa_logo_path = vim.fn.stdpath "config" .. "/resorces/Beihang-university-logo.svg"
      -- if my_utils.is_windows or not vim.fn.executable "chafa" then
      --   buaa_logo_section = {
      --     section = "header",
      --   }
      -- else
      --   buaa_logo_section = {
      --     section = "terminal",
      --     cmd = "chafa --format symbols --symbols vhalf " .. buaa_logo_path .. " --size 60x30; sleep .1",
      --     height = 30,
      --   }
      -- end

      opts.dashboard.preset.keys = {
        { key = "n", action = "<Leader>n", icon = get_icon("FileNew", 0, true), desc = "New File  " },
        { key = "f", action = "ff", icon = get_icon("Search", 0, true), desc = "Find File  " },
        { key = "r", action = "fo", icon = get_icon("DefaultFile", 0, true), desc = "Recents  " },
        { key = "s", action = "<Leader>sp", icon = get_icon("WordFile", 0, true), desc = "Search/grep project  " },
        { key = "'", action = "f'", icon = get_icon("Bookmarks", 0, true), desc = "Bookmarks  " },
        { key = "l", action = "<Leader>ql", icon = get_icon("Refresh", 0, true), desc = "Last session  " },
        { key = ".", action = "<Leader>q.", icon = "", desc = "load cwd(./) session" },
        { key = "q", action = "<Leader>Q", icon = get_icon("TabClose", 0, true), desc = "Quit vim  " },
        { key = "a", action = "<Leader>ha", icon = get_icon("Package", 0, true), desc = "Astronvim configuration" },
      }

      return require("astrocore").extend_tbl(opts, {
        dashboard = {
          sections = {
            { section = "keys", gap = 1, padding = 3 },
            { section = "startup" },
          },
        },
      })
    end,
  },

  -- trouble integration
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if require("astrocore").is_available "trouble.nvim" then
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = {
              trouble_open = function(...) return require("trouble.sources.snacks").actions.trouble_open.action(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-t>"] = { "trouble_open", mode = { "n", "i" } },
                },
              },
            },
          },
        })
      end
    end,
  },
  -- {
  --   "folke/snacks.nvim",
  --   ---@type snacks.Config
  --   specs = {
  --     {
  --       "AstroNvim/astrocore",
  --       ---@type AstroCoreOpts
  --       opts = {
  --         commands = {
  --           Pick = {
  --             function(cmd)
  --               local opts = { source = cmd.fargs[1] }
  --
  --               for i = 2, #cmd.fargs do
  --                 local k, v = cmd.fargs[i]:match "^(%w+)=(.*)$" -- escaping ws works
  --                 if not k then error("Invalid argument: " .. cmd.fargs[i]) end
  --                 if v == "true" then
  --                   opts[k] = true
  --                 elseif v == "false" then
  --                   opts[k] = false
  --                 else
  --                   opts[k] = vim.fn.expandcmd(v) -- lets $ENV , %:p, etc work
  --                 end
  --               end
  --
  --               Snacks.picker.pick(opts)
  --             end,
  --
  --             -- arglead, cmdline, cursorpos
  --             complete = function(arglead, cmdline, _)
  --               if cmdline == "Pick " then
  --                 return vim.tbl_keys(Snacks.picker.config.get().sources --[[@as table]])
  --               end
  --
  --               local opts = Snacks.picker.config.get { source = cmdline:match "Pick (%S+)" }
  --
  --               local opt = arglead:match "^(%w+)="
  --               if not opt then
  --                 local ret = { "cwd=" }
  --                 local skip = { enabled = true, source = true }
  --
  --                 for k, v in pairs(opts) do
  --                   if not skip[k] and type(v) ~= "table" then table.insert(ret, k .. "=") end
  --                 end
  --                 return ret
  --               end
  --
  --               if opt == "focus" then
  --                 return { "input", "list" }
  --               elseif opt == "finder" then
  --                 return vim
  --                   .iter(Snacks.picker.config.get().sources)
  --                   :map(function(_, v) return type(v.finder) == "string" and v.finder or nil end)
  --                   :totable()
  --               elseif opt == "layout" then
  --                 return vim.tbl_keys(Snacks.picker.config.get().layouts)
  --               elseif opt == "cwd" then
  --                 return vim.fn.getcompletion(arglead:sub(#opt + 2), "dir", true)
  --               elseif type(opts[opt]) == "boolean" then
  --                 return { "true", "false" }
  --               end
  --             end,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  --
}
