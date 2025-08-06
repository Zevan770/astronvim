return {
  {
    "Saghen/blink.cmp",
    version = "1.*",
    build = my_utils.is_windows and "" or "cargo build --release",
    enabled = my_utils.blink_enabled,
    ---@module 'blink.cmp'
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      opts.keymap = {
        preset = "super-tab",
        ["<C-y>"] = { "select_and_accept" },
      }

      opts.cmdline = {
        enabled = true,
        keymap = {
          preset = "inherit",
        },
        completion = {
          menu = { auto_show = true },
          trigger = {
            -- show_on_x_blocked_trigger_characters = { "'", '"', "(", "{", "!" },
          },
        },
      }
    end,
  },
  {
    "Saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          cmdline = {
            -- fix wsl stuck on cmdline completion
            enabled = function() return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match "^[%%0-9,'<>%-]*!" end,
          },
          lsp = {
            override = {
              get_trigger_characters = require("utils.blink").get_trigger_characters,
            },
          },
          -- buffer = {
          --   override = {
          --     get_trigger_characters = require("utils.blink").get_trigger_characters,
          --   },
          -- },
        },
      },
      signature = {
        window = {
          winblend = 10,
        },
      },
      completion = {
        menu = {
          max_height = 15,
          winblend = 10,
        },
        documentation = {
          window = {
            winblend = 10,
          },
          draw = function(data)
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
        list = {
          selection = {
            preselect = true,
          },
        },
        trigger = {
          show_on_blocked_trigger_characters = {},
        },
      },
      -- term = {
      --   enabled = true,
      -- },
      keymap = {
        ["<a-a>"] = {
          function()
            -- invoke manually, requires blink >v0.8.0
            require("blink-cmp").show { providers = { "lsp" } }
          end,
        },
      },
    },
  },
}
