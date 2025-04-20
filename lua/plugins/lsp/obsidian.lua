---@diagnostic disable: missing-fields
local notedir = vim.fn.has "win32" == 1 and "E:/desktop/notes" or "/mnt/e/Desktop/notes"
---@type LazySpec
return {
  "obsidian-nvim/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "bufreadpre " .. vim.fn.expand "~" .. "/my-vault/*.md" },
  event = {
    -- "BufReadPre  " .. notedir .. "/*.md",
    "BufReadPre *.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    -- {
    --   "saghen/blink.cmp",
    --   dependencies = { "saghen/blink.compat" },
    --   opts = {
    --     sources = {
    --       default = { "obsidian", "obsidian_new", "obsidian_tags" },
    --       providers = {
    --         obsidian = {
    --           name = "obsidian",
    --           module = "blink.compat.source",
    --         },
    --         obsidian_new = {
    --           name = "obsidian_new",
    --           module = "blink.compat.source",
    --         },
    --         obsidian_tags = {
    --           name = "obsidian_tags",
    --           module = "blink.compat.source",
    --         },
    --       },
    --     },
    --   },
    -- },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- -- HACK: to fix error, disable completion.nvim_cmp option and manually register sources
    -- local cmp = require "cmp"
    -- cmp.register_source("obsidian", require("cmp_obsidian").new())
    -- cmp.register_source("obsidian_new", require("cmp_obsidian_new").new())
    -- cmp.register_source("obsidian_tags", require("cmp_obsidian_tags").new())
  end,
  ---@type obsidian.config.ClientOpts
  opts = {
    ui = { enable = false },
    use_advanced_uri = true,
    finder = "telescope.nvim",
    -- dir = notedir,
    workspaces = {
      {
        name = "notes",
        path = notedir,
      },
      {
        name = "no-vault",
        path = function()
          -- alternatively use the CWD:
          return assert(vim.fn.getcwd())
        end,
        overrides = {
          notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
          new_notes_location = "notes_subdir",
          templates = {
            folder = vim.NIL,
          },
          disable_frontmatter = true,
        },
      },
    },
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = vim.ui.open or function(url) require("astrocore").system_open(url) end,
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function() return require("obsidian").util.gf_passthrough() end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function() return require("obsidian").util.toggle_checkbox() end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function() return require("obsidian").util.smart_action() end,
        opts = { buffer = true, expr = true },
      },
    },

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
      name = "snacks.pick",
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },

    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = "assets/imgs", -- This is the default

      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      img_name_func = function()
        -- Prefix image names with timestamp.
        return string.format("%s-", os.time())
      end,

      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
  },
}
