local markdown_ft = require("utils.filetype").markdown_like
local render_md_on_ft = require("astrocore").list_insert_unique(markdown_ft, { "gitcommit" })
local markview_on_ft = require("astrocore").list_insert_unique(markdown_ft, { "html", "yaml" })

---@type LazySpec
return {

  -- { import = "astrocommunity.pack.markdown" },

  -- #region render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = my_utils.markdown_render == "render",
    ft = render_md_on_ft,
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
      preset = "obsidian",
      nested = false,
      completions = { lsp = { enabled = true } },
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
      -- indent = {
      --   enabled = true,
      -- },
      code = {
        border = "thin",
      },
    },
  },
  -- #endregion

  {
    "OXY2DEV/markview.nvim",
    priority = 1001,
    lazy = false,
    enabled = my_utils.markdown_render == "markview",
    opts = function()
      local presets = require "markview.presets"

      ---@type markdown.headings
      local headings = vim.deepcopy(presets.headings.arrowed)
      headings.org_indent = true

      ---@module "markview"
      ---@type markview.config
      return {
        preview = {
          map_gx = false,
          modes = { "n", "no", "c", "i" },
          hybrid_modes = { "n", "i" },
          enable_hybrid_mode = true,
          linewise_hybrid_mode = true,
          debounce = 50,
          -- edit_range = { 2, 2 },

          icon_provider = "mini",
          filetypes = markview_on_ft,
          ignore_buftypes = {},
          condition = function(buffer)
            return true
            -- local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt
            --
            -- if bt == "nofile" and ft == "codecompanion" then
            --   return true
            -- elseif bt == "nofile" then
            --   return false
            -- else
            --   return true
            -- end
          end,
        },
        ---@diagnostic disable
        markdown = {
          headings = headings,
          -- list_items = {
          --   shift_width = function(buffer, item)
          --     --- Reduces the `indent` by 1 level.
          --     ---
          --     ---         indent                      1
          --     --- ------------------------- = 1 ÷ --------- = new_indent
          --     --- indent * (1 / new_indent)       new_indent
          --     ---
          --     local parent_indnet = math.max(1, item.indent - vim.bo[buffer].shiftwidth)
          --
          --     return item.indent * (1 / (parent_indnet * 2))
          --   end,
          --   marker_minus = {
          --     add_padding = function(_, item) return item.indent > 1 end,
          --   },
          -- },
          -- code_blocks = {
          --   label_direction = "left",
          --   style = "simple",
          --   -- style = "block",
          -- },
        },
        yaml = {
          enable = false,
        },
        experimental = {
          -- linewise_ignore_org_indent = true,
          check_rtp = false,
        },
        ---@diagnostic enable
      }
    end,
    config = function(_, opts)
      require("markview").setup(opts)
      require("utils.lsp_hover").setup {}
      require("markview.extras.editor").setup()
      -- require("markview.extras.headings").setup()
      require("markview.extras.checkboxes").setup()
    end,
    specs = {
      {
        "Saghen/blink.cmp",
        opts = {
          completion = {
            documentation = {
              draw = function(data)
                -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/402
                --

                ---@type integer
                local buf = data.window.buf
                ---@type integer
                local src_buf = vim.api.nvim_get_current_buf()

                ---@type string[]
                local lines = {}

                if data.item and data.item.documentation then
                  lines = vim.split(data.item.documentation.value or "", "\n", { trimempty = true })
                end

                ---@type string[]
                local details = vim.split(data.item.detail or "", "\n", { trimempty = true })

                if #details > 0 then
                  table.insert(details, 1, string.format("```%s", vim.bo[src_buf].ft or ""))
                  table.insert(details, "```")

                  if #lines > 0 then
                    details = vim.list_extend(details, {
                      "",
                      "Detail: ",
                      "--------",
                      "",
                    })
                  end
                end

                local visible_lines = vim.list_extend(details, lines)
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, visible_lines)

                if vim.g.__reg_doc ~= true then
                  vim.treesitter.language.register("markdown", "blink-cmp-documentation")
                  vim.g.__reg_doc = true
                end

                if package.loaded["markview"] then
                  local win = data.window:get_win()

                  if win then
                    vim.bo[buf].ft = "markdown"
                    require("markview").render(buf, { enable = true, hybrid_mode = false })
                    vim.bo[buf].ft = "blink-cmp-documentation"
                  end

                  vim.defer_fn(function()
                    win = data.window:get_win()

                    if win then vim.wo[win].signcolumn = "no" end

                    vim.bo[buf].ft = "markdown"
                    require("markview").render(buf, { enable = true, hybrid_mode = false })
                    vim.bo[buf].ft = "blink-cmp-documentation"
                  end, 25)
                elseif package.loaded["render-markdown"] then
                  local win = data.window:get_win()

                  if win then
                    vim.bo[buf].ft = "markdown"
                    require("render-markdown.core.ui").update(buf, win, "BlinkDraw", true)
                    vim.bo[buf].ft = "blink-cmp-documentation"
                  end

                  vim.defer_fn(function()
                    win = data.window:get_win()

                    if win then
                      vim.wo[win].signcolumn = "no"

                      vim.bo[buf].ft = "markdown"
                      require("render-markdown.core.ui").update(buf, win, "BlinkDraw", true)
                      vim.bo[buf].ft = "blink-cmp-documentation"
                    end
                  end, 25)
                end
              end,
            },
          },
        },
      },
    },
  },

  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
      vim.g.mkdp_filetypes = markdown_ft
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
