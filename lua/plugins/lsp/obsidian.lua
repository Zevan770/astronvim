---@type LazySpec
return {
  "epwalsh/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "bufreadpre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  event = {
    "BufReadPre  */notes/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    -- {
    --   "AstroNvim/astrocore",
    --   ---@type AstroCoreOpts
    --   opts = {
    --     mappings = {
    --       n = {
    --         ["gf"] = {
    --           function() return require("obsidian").util.gf_passthrough() end,
    --           desc = "Obsidian Follow Link",
    --         },
    --       },
    --     },
    --   },
    -- },
  },
  opts = {
    ui = { enable = false },
    use_advanced_uri = true,
    finder = "telescope.nvim",
    dir = vim.fn.has "win32" == 1 and "E:/desktop/大三上/notes" or "/mnt/e/desktop/大三上/notes",
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },

    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = vim.ui.open or function(url) require("astrocore").system_open(url) end,
  },
  keys = {
    {
      "gf",
      function() return require("obsidian").util.gf_passthrough() end,
      desc = "Obsidian Follow Link",
    },
  },
}
