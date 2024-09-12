---@type LazySpec
return {
  {
    "rainzm/flash-zh.nvim",
    event = "VeryLazy",
    dependencies = {
      { "folke/flash.nvim", optional = false },
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
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- highlight = {
      --   backdrop = false,
      --   matches = false,
      -- },
      char = {
        autohide = true,
      },
    },
    keys = {
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      {
        "<leader>n",
        mode = { "n" },
        function() require("flash").jump { continue = true } end,
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
    },
  },
}
