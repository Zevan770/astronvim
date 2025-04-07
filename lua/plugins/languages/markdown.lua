-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   callback = function() vim.opt_local.wrap = true end,
--   pattern = { "*.md", "*.txt" },
-- })
local markdown_ft = { "markdown", "Avante", "copilot-chat", "codecompanion" }
---@type LazySpec
return {

  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.markdown" },

  -- #region render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    cmd = "RenderMarkdown",
    -- enabled = false,
    ft = function()
      local plugin = require("lazy.core.config").spec.plugins["render-markdown.nvim"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      return opts.file_types or { "markdown" }
    end,
    opts = {
      preset = "obsidian",
      completions = { blink = { enabled = true } },
      file_types = markdown_ft,
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

  {
    "Myzel394/easytables.nvim",
    ft = markdown_ft,
    cmd = {
      "EasyTablesCreateNew",
      "EasyTablesImportThisTable",
    },
    opts = {
      table = {
        -- Whether to enable the header by default
        header_enabled_by_default = true,
        window = {
          preview_title = "Table Preview",
          prompt_title = "Cell content",
          -- Either "auto" to automatically size the window, or a string
          -- in the format of "<width>x<height>" (e.g. "20x10")
          size = "auto",
        },
        cell = {
          -- Min width of a cell (excluding padding)
          min_width = 3,
          -- Filler character for empty cells
          filler = " ",
          align = "left",
        },
      },
      export = {
        markdown = {
          -- Padding around the cell content, applied BOTH left AND right
          -- E.g: padding = 1, content = "foo" -> " foo "
          padding = 1,
          -- What markdown characters are used for the export, you probably
          -- don't want to change these
          characters = {
            horizontal = "-",
            vertical = "|",
            -- Filler for padding
            filler = " ",
          },
        },
      },
      set_mappings = function(buf)
        vim.api.nvim_buf_set_keymap(buf, "n", "<Left>", "<Cmd>JumpLeft<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Left>", "<Cmd>SwapWithLeftCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<Right>", "<Cmd>JumpRight<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Right>", "<Cmd>SwapWithRightCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<Up>", "<Cmd>JumpUp<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Up>", "<Cmd>SwapWithUpperCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<Down>", "<Cmd>JumpDown<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Down>", "<Cmd>SwapWithLowerCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<Tab>", "<Cmd>JumpToNextCell<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<S-Tab>", "<Cmd>JumpToPreviousCell<CR>", { silent = true })

        vim.api.nvim_buf_set_keymap(buf, "n", "<C-Left>", "<Cmd>SwapWithLeftColumn<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<C-Right>", "<Cmd>SwapWithRightColumn<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<C-Up>", "<Cmd>SwapWithUpperRow<CR>", { silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<C-Down>", "<Cmd>SwapWithLowerRow<CR>", { silent = true })
      end,
    },
  },

  {
    "Kicamon/markdown-table-mode.nvim",
    config = true,
    ft = markdown_ft,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function(plugin)
      local package_manager = vim.fn.executable "yarn" and "yarn" or vim.fn.executable "npx" and "npx -y yarn" or false

      --- HACK: Use `yarn` or `npx` when possible, otherwise throw an error
      ---@see https://github.com/iamcco/markdown-preview.nvim/issues/690
      ---@see https://github.com/iamcco/markdown-preview.nvim/issues/695
      if not package_manager then error "Missing `yarn` or `npx` in the PATH" end

      local cmd = string.format(
        "!cd %s && cd app && COREPACK_ENABLE_AUTO_PIN=0 %s install --frozen-lockfile",
        plugin.dir,
        package_manager
      )

      vim.cmd(cmd)
    end,
    ft = { "markdown", "markdown.mdx" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
      local plugin = require("lazy.core.config").spec.plugins["markdown-preview.nvim"]
      vim.g.mkdp_filetypes = require("lazy.core.plugin").values(plugin, "ft", true)
      -- vim.g.mkdp_browser = vim.env.BROWSER .. ""
      -- vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_combine_preview = 1
    end,
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Markdown = "" } } },
      {
        "AstroNvim/astrocore",
        optional = true,
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>M"

          maps.n[prefix] = { desc = require("astroui").get_icon("Markdown", 1, true) .. "Markdown" }
          maps.n[prefix .. "p"] = { "<cmd>MarkdownPreview<cr>", desc = "Preview" }
          maps.n[prefix .. "s"] = { "<cmd>MarkdownPreviewStop<cr>", desc = "Stop preview" }
          maps.n[prefix .. "t"] = { "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle preview" }
        end,
      },
    },
  },
}
