-- if true then return {} end
---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = { enabled = not not vim.env.KITTY_PID },
      dim = { enabled = true },
      picker = {
        actions = {},
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
          maps.n["<Leader>hD"] = {
            function()
              Snacks.picker.grep {
                dirs = astro_dirs,
                title = title,
                glob = { "*.lua" },
              }
            end,
            desc = "grep" .. title,
          }
          maps.n["<Leader>hd"] = {
            function()
              Snacks.picker.files {
                dirs = astro_dirs,
                title = title,
              }
            end,
            desc = title,
          }
          maps.n["<Leader>sp"] = maps.n["<Leader>fw"]
          maps.n["<Leader>/"] = maps.n["<Leader>fw"]
          maps.n["<Leader>sP"] = maps.n["<Leader>fc"]
          maps.n["<C-p>"] = maps.n["<Leader>ff"]
          maps.n["<Leader>pf"] = maps.n["<Leader>ff"]
          maps.n["<Leader>fb"] = {
            function() Snacks.picker.buffers { layout = "ivy_split" } end,
            desc = maps.n["<Leader>fb"].desc,
          }
          maps.n["<A-b>"] = maps.n["<Leader>fb"]
          maps.n["<A-x>"] = maps.n["<Leader>fC"]

          maps.n["<Leader>fc"] = { function() Snacks.picker.commands() end, desc = "Find Commands" }
          maps.n["<Leader>fr"] = { function() Snacks.picker.recent() end, desc = "Find Recents" }
          maps.n["<Leader>fj"] = { function() Snacks.picker.jumps() end, desc = "Find Jumps" }
          maps.n["<Leader>fu"] = { function() Snacks.picker.undo() end, desc = "Find Undo history" }
          maps.n["<Leader>fx"] = { function() Snacks.picker.lazy() end, desc = "Find lazy eXtension specs" }
          maps.n["<Leader>fz"] = {
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
                          vim.cmd "tabnew"
                          Snacks.notify "New tab opened"
                          picker:close()
                          Snacks.picker.zoxide()
                        end,
                        mode = { "n", "i" },
                      },
                    },
                  },
                },
                confirm = "tcd",
              }
            end,
            desc = "Find Zoxide",
          }
          maps.n['<Leader>f"'] = { function() Snacks.picker.registers() end, desc = "Find register" }
          maps.n["<Leader>f:"] = { function() Snacks.picker.command_history() end, desc = "Find Command history" }
          maps.n["<Leader>f/"] = { function() Snacks.picker.search_history() end, desc = "Find Search history" }

          maps.n["<Leader>f<space>"] = { function() Snacks.picker() end, desc = "pick ?" }

          maps.n["<Leader>fe"] = { function() Snacks.picker.explorer() end, desc = "Snacks treE" }
          maps.c["<C-t>"] = {
            function()
              vim.api.nvim_feedkeys(vim.keycode "<Esc>", "n", true)
              Snacks.picker.command_history {
                config = function(o) o.pattern = vim.fn.getreg ":" end,
              }
            end,
            desc = "command history",
          }

          maps.n["<Leader>."] = { function() Snacks.scratch() end, desc = "new Scratch buffer" }

          maps.n["<Leader>ap"] = { function() Snacks.profiler.scratch() end, desc = "Profiler" }

          maps.n["<Leader>lg"] = {
            function() require("snacks").picker.lsp_workspace_symbols() end,
            desc = "Search workspace symbols",
          }
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

      local buaa_logo_section
      local buaa_logo_path = vim.fn.stdpath "config" .. "/resorces/Beihang-university-logo.svg"
      if my_utils.is_windows or not vim.fn.executable "chafa" then
        buaa_logo_section = {
          section = "header",
        }
      else
        buaa_logo_section = {
          section = "terminal",
          cmd = "chafa --format symbols --symbols vhalf " .. buaa_logo_path .. " --size 60x30; sleep .1",
          height = 30,
        }
      end

      opts.dashboard.preset.keys = {
        { key = "n", action = "<Leader>n", icon = get_icon("FileNew", 0, true), desc = "New File  " },
        { key = "f", action = "<Leader>ff", icon = get_icon("Search", 0, true), desc = "Find File  " },
        { key = "r", action = "<Leader>fo", icon = get_icon("DefaultFile", 0, true), desc = "Recents  " },
        { key = "s", action = "<Leader>sp", icon = get_icon("WordFile", 0, true), desc = "Search/grep project  " },
        { key = "'", action = "<Leader>f'", icon = get_icon("Bookmarks", 0, true), desc = "Bookmarks  " },
        { key = "l", action = "<Leader>Sl", icon = get_icon("Refresh", 0, true), desc = "Last session  " },
        { key = "c", action = "<Leader>pc", icon = "", desc = "Current dir session" },
        { key = "q", action = "<Leader>Q", icon = get_icon("TabClose", 0, true), desc = "Quit vim  " },
        { key = "a", action = "<Leader>fa", icon = get_icon("Package", 0, true), desc = "Astronvim configuration" },
      }

      -- opts.dashboard = {
      --   preset = {
      --     keys = {
      --       { key = "n", action = "<Leader>n", icon = get_icon("FileNew", 0, true), desc = "New File  " },
      --       { key = "f", action = "<Leader>ff", icon = get_icon("Search", 0, true), desc = "Find File  " },
      --       { key = "r", action = "<Leader>fo", icon = get_icon("DefaultFile", 0, true), desc = "Recents  " },
      --       { key = "s", action = "<Leader>fw", icon = get_icon("WordFile", 0, true), desc = "grep Search project  " },
      --       { key = "'", action = "<Leader>f'", icon = get_icon("Bookmarks", 0, true), desc = "Bookmarks  " },
      --       { key = "l", action = "<Leader>Sl", icon = get_icon("Refresh", 0, true), desc = "Last session  " },
      --       { key = "q", action = "<Leader>Q", icon = get_icon("TabClose", 0, true), desc = "Quit vim  " },
      --       { key = "c", action = "<Leader>fa", icon = get_icon("Package", 0, true), desc = "open Configuration" },
      --     },
      --     header = [[
      --                                  .:i1ttftfffffffffftffft1i:.
      --                             .;1ffft1;:..,.         ,...:;1tfff1;.
      --                          :1fft;,.     ,;CC1f:     iL,,1.    .,itff1:
      --                       :tLfi.  ,.      ft1fi..   :1Giif1,         .ifLt:
      --                    .1Lfi.  L::Gt.      .L8t:    i1f;iti,     .;Gf;  .ifL1.
      --                  .tCt,    ,LG;;f1i1    ::..           i:  .:;080L,     ,tCt.
      --                .tC1        t8ff::i:  .,:i1tfffLLfftt1;,.   :;:Cf         .1Ct.
      --               iGt..,:,    .;:,,  .;fLLLf1i;::,,,,:;i1tLLLf1,  .Cf,    ..  ..tGi
      --             .LC,  fC1L ,,     ,tCCfi,                   ,;tLCf; ..  ,,iGtC0. ,CL.
      --            ,0t   .t:L8tf;   iCCt,                           .iCGt.  ,tiC8tt    t0,
      --           ;8i     . ,:t;  1GL;             .                   ,fGf.   f8       i8;
      --          :8;         ;  :GC:              ii             ,;Lt.   ,f01  ,t.       ;8:
      --         ,8;  ;fG,,1    t81            ...,GG...      ,iLG@@f,,,:1. :0C.     ,;.,, ;8,
      --         0t   ii1ift   L8,             ;tLG@@Lt;,.:1L0@@@@81.,.:;.    C0.   .iLCfL; t0
      --        t0   .L@C1    L8.          ,;tLfi. GL.:1C8@@@@@@@C,   ::       L8. LffLfGCCf 0t
      --       .8;     ;:G1  1@,       ,1C0@@81. ,;C08@@@@@@@@@@f   .;,         0C ,,.; 1t.: ;8.
      --       10        ,: .@1      ;C@@@@@f  ;L0@@@@@@@@@@@@8i   .iGCi        ,@i           01
      --       Gf           t8     ,C@@@@@@L   .:;;t8@@@@@@@@G,   :t8@@@G,       C0           fG
      --       8;           0L    .0@@@@@@@,   .:,..:8@@@@@@f   ,:i@@@@@@0.      i@.          i8
      --       @:           8t    ;@@@@@@@8         .8@@@@@i   :; :@@@@@@@i      :@:          :@
      --       @:           8t    ,G0G0000G.        1@@@@0:   :,  ;8088080,      :@:          :@
      --       8;           0C     f0GGGGGGGCGGGGGGi0@@@L.  .1GCGCG000000L       i@.          i8
      --       Gf           t@     ;i1LLLLLCfiiiiiif@@@1   ,::iiiLCLLLL1i;       CG           fG
      --       10           .@t   ,CGG0000880GGCCGi8@8L  .;CGCCG0888800GGGt     :@;           01
      --       .8;           i@,  .;;;::::;;1fCGL;C@L:, ,:,;1LCf1;;::::;;;:     0C    ,,.    ;8.
      --        t0    ,i1:    f8,              .,1@t , ::  .,.                 C0     :::    0t
      --         0t    ,,      f8:              ,0; :,:,                     .GG.   ..      t0
      --         ,8;     :;,    18t            .1, ,i:.                     ;0L     :::    ;8,
      --          :8;   .:.      ,CG;             .t,                     ,L0i   ..   .   ;8:
      --           ;8i     .:,     iGCi           ..                    :LGt     .::.    i8;
      --            ,0t    ,. .,     ;LGf;        ::,;;.;i ,i.       ,1CC1.    :,.      t0,
      --             .LC,    .;i;.     ,1LCL1:.   :: :i ,; ,:   .,ifCCt:       :;,    ,CL.
      --               iGt.    ,   ,.     .;tLLLftt1;;::;:;1ttfLLLti,      ,1;.     .tGi
      --                .tC1.    .,1.  ,       ,:i1ttffffftt1i;,.      ,,.  ::.   .1Ct.
      --                  .tCt,    .  .i;.  .                     .... .i:.     ,tCt.
      --                    .1Lfi.    ..,  ;::.     .. .  ,..  :. .:i.       .ifL1.
      --                       :tLfi,      .,:      ,i.,  ;;:  ::   .     ,ifLt:
      --                          :1ffti,.           ,.   . .        .,itff1:
      --                             .;1tfft1;:,.             .,:;1tfft1;.
      --                                  .:;1ttffffffffffffffftt1;:.
      --     ]],
      --   },
      --   sections = {
      --     buaa_logo_section,
      --     { section = "keys", gap = 1, padding = 3 },
      --     { section = "startup" },
      --   },
      -- }
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
                  ["<a-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
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

  {
    "dawsers/file-history.nvim",
    enabled = not my_utils.is_windows,
    config = function()
      local file_history = require "file_history"
      file_history.setup {
        -- These are the default values, change them if needed
        -- Location where the plugin will create your file history repository
        backup_dir = "~/.file-history-git",
        -- command line to execute git
        git_cmd = "git",
        -- If you want to override the automatic query for hostname, change this
        -- option. By default (nil), the plugin gets the host name for the computer
        -- it is running on.
        --
        -- You should only modify this value if you understand the following:
        -- This plugin writes a backup copy of every file you edit in neovim, not
        -- just your coding projects. When copying the file-history repository from
        -- one computer to another, having the hostname added to each file in the
        -- repo prevents you from messing the history of files that should be unique
        -- to that computer (host). For example, configuration and system files
        -- will probably be different in part or fully. So, even though it may
        -- make sense for coding projects to be able to move the database and
        -- disregard the host name, in many cases you will be editing other types
        -- of files, where keeping the correct host name will help you recover
        -- from mistakes.
        hostname = nil,
      }
    -- There are no default key maps, this is an example
    -- stylua: ignore start
    vim.keymap.set('n', '<leader>Bb',function() file_history.backup() end, { silent = true, desc = 'named backup for file' })
    vim.keymap.set('n', '<leader>Bh', function() file_history.history() end, { silent = true, desc = 'local history of file' })
    vim.keymap.set('n', '<leader>Bf', function() file_history.files() end, { silent = true, desc = 'local history files in repo' })
    vim.keymap.set('n', '<leader>Bq', function() file_history.query() end, { silent = true, desc = 'local history query' })
      -- stylua: ignore end
    end,
  },
}
