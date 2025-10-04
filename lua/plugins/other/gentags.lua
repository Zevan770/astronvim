if true then return {} end
---@type LazySpec
return {
  {
    "linrongbin16/gentags.nvim",
    dev = true,
    ---@module "gentags"
    ---@type gentags.Options
    opts = {
      -- binary name
      tool = "ptags",

      -- ctags options
      ctags = {
        "--tag-relative=never",

        -- Recommended Options:

        -- exclude logs
        "--exclude=*.log",

        -- exclude vcs
        "--exclude=*.git",
        "--exclude=*.svg",
        "--exclude=*.hg",

        -- exclude nodejs
        "--exclude=node_modules",

        -- exclude tags/cscope
        "--exclude=*tags*",
        "--exclude=*cscope.*",

        -- exclude python
        "--exclude=*.pyc",

        -- exclude jvm class
        "--exclude=*.class",

        -- exclude VS project generated
        "--exclude=*.pdb",
        "--exclude=*.sln",
        "--exclude=*.csproj",
        "--exclude=*.csproj.user",

        -- exclude blobs
        "--exclude=*.exe",
        "--exclude=*.dll",
        "--exclude=*.mp3",
        "--exclude=*.ogg",
        "--exclude=*.flac",
        "--exclude=*.swp",
        "--exclude=*.swo",
        "--exclude=*.bmp",
        "--exclude=*.gif",
        "--exclude=*.ico",
        "--exclude=*.jpg",
        "--exclude=*.png",
        "--exclude=*.rar",
        "--exclude=*.zip",
        "--exclude=*.tar",
        "--exclude=*.tar.gz",
        "--exclude=*.tar.xz",
        "--exclude=*.tar.bz2",
        "--exclude=*.pdf",
        "--exclude=*.doc",
        "--exclude=*.docx",
        "--exclude=*.ppt",
        "--exclude=*.pptx",
      },

      ptags = {},
      -- workspace detection
      workspace = { ".git", ".svn", ".hg" },

      -- excluded workspace
      disabled_workspaces = {},

      -- excluded filetypes
      disabled_filetypes = {},

      -- excluded filenames
      disabled_filenames = {},

      -- cache directory
      -- For *NIX: `~/.cache/nvim/gentags.nvim`.
      -- For Windows: `$env:USERPROFILE\AppData\Local\Temp\nvim\gentags.nvim`.
      -- cache_dir = path.join(vim.fn.stdpath "cache", "gentags.nvim"),

      -- garbage collection
      gc = {
        -- policy:
        --   - LRU (least recently used): remove the least recently used.
        --- @type "LRU"
        policy = "LRU",

        -- trigger by:
        --  * count: by tags cache count, for example: 100.
        --  * size: by tags cache size, for example: 1GB, 300MB, 4096KB, with suffix "GB", "MG", "KB".
        --
        --- @type {name:"count"|"size",value:string|integer}|nil
        trigger = { name = "size", value = "1GB" },

        -- tags cache that will be exclude from gc.
        exclude = {},
      },

      -- user command
      command = { name = "GenTags", desc = "Generate tags" },

      -- debug options
      debug = {
        -- enable debug mode
        enable = false,

        -- print logs to messages.
        console_log = true,

        -- write logs to file.
        -- For *NIX: `~/.local/share/nvim/gentags.log`.
        -- For Windows: `$env:USERPROFILE\AppData\Local\nvim-data\gentags.log`.
        file_log = false,
      },
    },
    -- enabled = false,
  },
  {
    "JMarkin/gentags.lua",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = {},
  },
}
