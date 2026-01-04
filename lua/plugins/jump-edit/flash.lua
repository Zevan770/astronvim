-- if true then return {} end
local H = {}
H.flash_remote_lsp = function(leader_key)
  local prev_timeout = vim.opt.timeout

  vim.opt.timeout = false

  require("flash").jump {
    action = function(match, state)
      state:hide()

      local row, col = unpack(vim.api.nvim_win_get_cursor(0))

      vim.api.nvim_set_current_win(match.win)
      vim.api.nvim_win_set_cursor(match.win, match.pos)

      local key = vim.api.nvim_replace_termcodes("<Ignore>" .. leader_key, true, true, true)

      vim.api.nvim_feedkeys(key, "i", false)

      vim.schedule(function()
        -- vim.api.nvim_win_set_cursor(match.win, { row, col })
        -- state:restore()
        vim.opt.timeout = prev_timeout
      end)
    end,
    -- search = {
    --   max_length = 2,
    -- },
    -- label = {
    --   before = { 0, 2 },
    --   after = false,
    -- },
  }
end

---@type LazySpec
return {
  {
    "folke/flash.nvim",
    event = "User AstroFile",
    ---@module 'flash'
    ---@type Flash.Config
    opts = {
      labels = "fjghdktyrueivncmwoxsla;qp",
      label = {
        uppercase = true,
      },

      modes = {
        char = {
          enabled = false,
          -- set to `false` to use the current line only
          multi_line = true,
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
            }
          end,
          jump = {
            register = false,
          },
        },
        treesitter_search = {
          search = {
            mode = "fuzzy",
          },
          label = {
            rainbow = {
              enabled = true,
              -- number between 1 and 9
              shade = 7,
            },
          },
        },
        treesitter = {
          label = {
            rainbow = {
              enabled = true,
              -- number between 1 and 9
              shade = 5,
            },
          },
          -- highlight = { backdrop = true },
        },
      },
    },
    keys = {
      {
        "R",
        function() require("flash").treesitter_search { remote_op = { restore = true } } end,
        desc = "Treesitter Search",
        mode = { "o", "x" },
      },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      -- {
      --   "<A-s>",
      --   mode = { "n" },
      --   function() require("flash").jump { pattern = vim.fn.getreg "/" } end,
      --   desc = "Toggle Flash Search",
      -- },
      { "gb", function() H.flash_remote_lsp "g" end },
      { ".", mode = { "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- {
      --   "gs[",
      --   "<Cmd>lua require('flash').treesitter({jump={pos='start'}})<CR>",
      --   mode = { "n", "o", "x" },
      --   desc = "Outter Start Of Treesitter Node",
      -- },
      -- {
      --   "gs]",
      --   "<Cmd>lua require('flash').treesitter({jump={pos='end'}})<CR>",
      --   mode = { "n", "o", "x" },
      --   desc = "Outter end Of Treesitter Node",
      -- },
      {
        "<leader>jl",
        mode = { "n", "v", "o" },
        function()
          require("flash").jump {
            search = { forward = true, mode = "search", max_length = 0 },
            -- label = { before = true, after = false },
            label = {
              after = { 0, vim.api.nvim_win_get_cursor(0)[2] },
            },
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
              i = { ["<a-s>"] = flash },
            },
          })
        end,
      },
      {
        "folke/snacks.nvim",
        optional = true,
        ---@type snacks.Config
        opts = {
          picker = {
            win = {
              input = {
                keys = {
                  ["<a-s>"] = { { "flash", "confirm" }, mode = { "n", "i" } },
                  ["s"] = { "flash" },
                },
              },
            },
            actions = {
              flash = function(picker)
                require("flash").jump {
                  pattern = "^",
                  label = { after = { 0, 0 } },
                  highlight = { backdrop = false },
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
    dependencies = {
      { "folke/flash.nvim" },
    },
    keys = {
      {
        "r",
        function()
          local opts = {}
          local Config = require "flash.config"
          opts = Config.get({ mode = "remote" }, opts)
          return require("flash-zh").jump(opts)
        end,
        desc = "Remote Flash",
        mode = { "o" },
      },
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- if vim.v.hlsearch == 1 then
          --   require("flash-zh").jump {
          --     chinese_only = false,
          --     pattern = vim.fn.getreg "/",
          --   }
          -- else
          require("flash-zh").jump {
            chinese_only = false,
          }
          -- end
        end,
        desc = "Flash between Chinese",
      },
    },
  },
}
