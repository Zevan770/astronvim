-- if true then return {} end
---@type LazySpec
return {
  { import = "astrocommunity.motion.flash-nvim" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.labels = "fjghdktyrueivncmwoxsla;qp"
      opts.modes = {
        -- search = {
        --   enabled = true,
        -- },
        char = {
          enabled = true,
          -- dynamic configuration for ftFT motions
          config = function(opts)
            -- autohide flash when in operator-pending mode
            opts.autohide = opts.autohide or (vim.fn.mode(true):find "no" and vim.v.operator == "y")

            -- disable jump labels when not enabled, when using a count,
            -- or when recording/executing registers
            opts.jump_labels = opts.jump_labels
              and vim.v.count == 0
              and vim.fn.reg_executing() == ""
              and vim.fn.reg_recording() == ""

            -- Show jump labels only in operator-pending mode
            -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find "o"
          end,
          -- hide after jump when not using jump labels
          autohide = true,
          -- show jump labels
          jump_labels = true,
          -- set to `false` to use the current line only
          multi_line = false,
          -- When using jump labels, don't use these keys
          -- This allows using those keys directly after the motion
          label = { exclude = "hjkliarydc" },
          -- by default all keymaps are enabled, but you can disable some of them,
          -- by removing them from the list.
          -- If you rather use another key, you can map them
          -- to something else, e.g., { [";"] = "L", [","] = H }
          keys = { "f", "F", "t", "T" },
          ---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
          -- The direction for `prev` and `next` is determined by the motion.
          -- `left` and `right` are always left and right.
          char_actions = function(motion)
            return {
              -- [";"] = "next", -- set to `right` to always go right
              -- [","] = "prev", -- set to `left` to always go left
              -- clever-f style
              [motion:lower()] = "next",
              [motion:upper()] = "prev",
              -- jump2d style: same case goes next, opposite case goes prev
              -- [motion] = "next",
              -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
            }
          end,
          search = { wrap = false },
          highlight = { backdrop = true },
          jump = {
            register = false,
            -- when using jump labels, set to 'true' to automatically jump
            -- or execute a motion when there is only one match
            autojump = true,
          },
        },
      }
      return opts
    end,
    keys = {
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      {
        "<A-s>",
        mode = { "n" },
        function() require("flash").jump { pattern = vim.fn.getreg "/" } end,
        desc = "Toggle Flash Search",
      },
      {
        "<leader>*",
        mode = { "n", "v" },
        function()
          require("flash").jump {
            pattern = vim.fn.expand "<cword>",
          }
        end,
        desc = "Flash Cword",
      },
      {
        "<C-Space>",
        mode = { "n", "v" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      {
        "<leader>jl",
        mode = { "n", "v", "o" },
        function()
          require("flash").jump {
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, vim.api.nvim_win_get_cursor(0)[2] } },
            style = "right_align",
            pattern = "^",
          }
        end,
      },
    },
    specs = {
      {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function(_, opts)
          local function flash(prompt_bufnr)
            require("flash").jump {
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults" end,
                },
              },
              action = function(match)
                local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                picker:set_selection(match.pos[1] - 1)
              end,
            }
          end
          opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
            mappings = {
              n = { s = flash },
              i = { ["<c-s>"] = flash },
            },
          })
        end,
      },
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          picker = {
            win = {
              input = {
                keys = {
                  ["<a-s>"] = { "flash", mode = { "n", "i" } },
                  ["s"] = { "flash" },
                },
              },
            },
            actions = {
              flash = function(picker)
                require("flash").jump {
                  pattern = "^",
                  label = { after = { 0, 0 } },
                  search = {
                    mode = "search",
                    exclude = {
                      function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list" end,
                    },
                  },
                  action = function(match)
                    local idx = picker.list:row2idx(match.pos[1])
                    picker.list:_move(idx, true, true)
                  end,
                }
              end,
            },
          },
        },
      },
    },
  },
  {
    "rainzm/flash-zh.nvim",
    -- enabled = false,
    event = "VeryLazy",
    dependencies = {
      { "folke/flash.nvim" },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash-zh").jump {
            chinese_only = false,
          }
        end,
        desc = "Flash between Chinese",
      },
    },
  },
}
