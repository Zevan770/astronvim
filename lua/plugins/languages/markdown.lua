local markdown_ft = { "markdown", "Avante", "quarto", "rmd", "html", "copilot-chat", "codecompanion" }
local render_md_on_ft = table.insert(vim.deepcopy(markdown_ft), "gitcommit")
local markview_on_ft = require("astrocore").list_insert_unique(markdown_ft, { "html", "yaml" })
---@type LazySpec
return {

  "AstroNvim/astrocommunity",
  -- { import = "astrocommunity.pack.markdown" },

  -- #region render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    cmd = "RenderMarkdown",
    -- enabled = false,
    ft = render_md_on_ft,
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
      preset = "obsidian",
      completions = { blink = { enabled = true } },
      injections = {
        -- Out of the box language injections for known filetypes that allow markdown to be interpreted
        -- in specified locations, see :h treesitter-language-injections.
        -- Set enabled to false in order to disable.
        gitcommit = {
          enabled = true,
          query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
        },
      },
      file_types = render_md_on_ft,
      code = {
        border = "thin",
      },
    },
  },
  -- #endregion

  {
    "OXY2DEV/markview.nvim",
    -- ft = function()
    --   local plugin = require("lazy.core.config").spec.plugins["markview.nvim"]
    --   local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    --   return opts.filetypes or { "markdown", "quarto", "rmd" }
    -- end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
            "html",
            "markdown",
            "markdown_inline",
          })
        end
      end,
    },
    opts = function()
      local presets = require "markview.presets"
      ---@type mkv.config
      return {
        preview = {
          modes = { "n", "no", "c", "i" },
          hybrid_modes = { "i" },
          enable_hybrid_mode = true,
          linewise_hybrid_mode = true,
          edit_range = { 3, 2 },

          icon_provider = "mini",
          filetypes = markview_on_ft,
        },
        ---@diagnostic disable
        markdown = {
          headings = presets.headings.slanted,
          list_items = {
            indent_size = 2,
            shift_width = 0,
            --   function (buffer, item)
            --   return
            -- end
          },
        },
        ---@diagnostic enable
      }
    end,
    config = function(_, opts)
      require("markview").setup(opts)
      require("markview.extras.editor").setup()
      require("markview.extras.headings").setup()
      require("markview.extras.checkboxes").setup()
    end,
  },

  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
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
