return {
  -- oil.nvim refined
  {
    "barrettruth/canola.nvim",
    branch = "canola",
    cmd = "Canola",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>oc"] = { function() require("canola").open() end, desc = "Open folder in Canola" },
            },
          },
          autocmds = {
            canola_settings = {
              {
                event = "FileType",
                desc = "Disable view saving for canola buffers",
                pattern = "canola",
                callback = function(args) vim.b[args.buf].view_activated = false end,
              },
              {
                event = "User",
                pattern = "CanolaActionsPost",
                desc = "Close buffers when files are deleted in Canola",
                callback = function(args)
                  if args.data.err then return end
                  for _, action in ipairs(args.data.actions) do
                    if action.type == "delete" then
                      local _, path = require("canola.util").parse_url(action.url)
                      local bufnr = vim.fn.bufnr(path)
                      if bufnr ~= -1 then require("astrocore.buffer").wipe(bufnr, true) end
                    end
                  end
                end,
              },
            },
          },
        },
      },
      {
        "rebelot/heirline.nvim",
        optional = true,
        dependencies = {
          "AstroNvim/astroui",
          opts = { status = { winbar = { enabled = { filetype = { "^canola$" } } } } },
        },
        opts = function(_, opts)
          if opts.winbar then
            local status = require "astroui.status"
            table.insert(opts.winbar, 1, {
              condition = function(self) return status.condition.buffer_matches({ filetype = "^canola$" }, self.bufnr) end,
              status.component.separated_path {
                padding = { left = 2 },
                max_depth = false,
                suffix = false,
                path_func = function(self) return require("canola").get_current_dir(self.bufnr) end,
              },
            })
          end
        end,
      },
    },
    init = function()
      local get_icon = require("astroui").get_icon
      vim.g.canola = {
        -- columns = { { "icon", default_file = get_icon "DefaultFile", directory = get_icon "FolderClosed" } },
        -- Canola will take over directory buffers (e.g. `vim .` or `:e src/`)
        -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
        keymaps = {
          ["<left>"] = "actions.parent",
          ["<right>"] = "actions.select",
          ["<C-s>"] = { callback = function() vim.cmd.write() end },
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              vim.b.canola_detail = not vim.b.canola_detail
              local detail = vim.b.canola_detail
              if detail then
                require("canola").set_columns { "icon", "permissions", "size", "mtime" }
              else
                require("canola").set_columns { "icon" }
              end
            end,
          },
        },
      }
    end,
  },
  {
    "barrettruth/canola-collection",
    init = function()
      vim.g.canola_git = {}
      vim.g.canola_trash = {}
    end,
  },
}
