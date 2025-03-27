local notedir = vim.fn.has "win32" == 1 and "E:/desktop/notes" or "/mnt/e/Desktop/notes"
---@type LazySpec
return {
  "obsidian-nvim/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "bufreadpre " .. vim.fn.expand "~" .. "/my-vault/*.md" },
  event = {
    "BufReadPre  " .. notedir .. "/*.md",
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

    -- -- HACK: fix error, disable completion.nvim_cmp option, manually register sources
    -- local cmp = require "cmp"
    -- cmp.register_source("obsidian", require("cmp_obsidian").new())
    -- cmp.register_source("obsidian_new", require("cmp_obsidian_new").new())
    -- cmp.register_source("obsidian_tags", require("cmp_obsidian_tags").new())
  end,
  opts = {
    ui = { enable = false },
    use_advanced_uri = true,
    finder = "telescope.nvim",
    dir = notedir,
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

    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then note:add_alias(note.title) end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

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
  },
}
