-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   callback = function() vim.opt_local.wrap = true end,
--   pattern = { "*.md", "*.txt" },
-- })

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.markdown" },
  -- { import = "astrocommunity.note-taking.obsidian-nvim" },

  -- #region render-markdown.nvim
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = { file_types = { "markdown", "Avante", "copilot-chat", "codecompanion" } },
    dependencies = {
      "nvim-cmp",
      opts = function(_, opts)
        local cmp = require "cmp"
        cmp.setup {
          sources = cmp.config.sources {
            { name = "render-markdown" },
          },
        }
      end,
    },
  },
  -- #endregion

  -- {
  --   "OXY2DEV/markview.nvim",
  --   ft = function()
  --     local plugin = require("lazy.core.config").spec.plugins["markview.nvim"]
  --     local opts = require("lazy.core.plugin").values(plugin, "opts", false)
  --     return opts.filetypes or { "markdown", "quarto", "rmd" }
  --   end,
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     opts = function(_, opts)
  --       if opts.ensure_installed ~= "all" then
  --         opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
  --           "html",
  --           "markdown",
  --           "markdown_inline",
  --         })
  --       end
  --     end,
  --   },
  --   ---@type mkv.config
  --   opts = {
  --     preview = {
  --       hybrid_modes = { "n" },
  --       enable_hybrid_mode = true,
  --       modes = { "n", "c" },
  --       linewise_hybrid_mode = true,
  --
  --       callbacks = {
  --         on_enable = function(_, win)
  --           -- This will prevent Tree-sitter concealment being disabled on the cmdline mode
  --           vim.wo[win].concealcursor = "c"
  --           vim.wo[win].conceallevel = 2
  --         end,
  --       },
  --       icon_provider = "devicons",
  --       filetypes = {
  --         "avante",
  --         "markdown",
  --         "quarto",
  --         "rmd",
  --         "html",
  --         "yaml",
  --         "codecompanion",
  --         "copilot",
  --       },
  --     },
  --     ---@diagnostic disable
  --     markdown = {
  --       list_items = {
  --         wrap = true,
  --         indent_size = function(buffer, item) end,
  --       },
  --       code_blocks = {
  --         style = "simple"
  --       }
  --     },
  --     ---@diagnostic enable
  --   },
  --   config = function(_, opts)
  --     require("markview.extras.editor").setup()
  --     require("markview.extras.headings").setup()
  --     require("markview.extras.checkboxes").setup()
  --     require("markview").setup(opts)
  --   end,
  -- },

  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        my_ft_markdown = {
          {
            event = "Filetype",
            pattern = "markdown",
            callback = function() vim.opt_local.wrap = true end,
          },
        },
      },
    },
  },
}
