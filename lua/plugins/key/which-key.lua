---@type LazySpec
return {
  "folke/which-key.nvim",
  ---@class wk.Opts
  opts = {
    preset = "modern",
    delay = 100,
    keys = {
      scroll_down = "<tab>", -- binding to scroll down inside the popup
      scroll_up = "<S-tab>", -- binding to scroll up inside the popup
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts) -- Configure core features of AstroNvim
        -- persist mode
        local maps = assert(opts.mappings)
        maps.n["<Leader>d<Space>"] = {
          function()
            require("which-key").show {
              keys = "<leader>d",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
          desc = "enter debug persist mode",
        }
        maps.n["]<Space>"] = {
          function()
            require("which-key").show {
              keys = "]",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
        }

        maps.n["[<Space>"] = {
          function()
            require("which-key").show {
              keys = "[",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
        }

        -- #region transient mode
        -- local maps_clone = vim.deepcopy(maps)
        -- -- stylua: ignore
        -- local maps_to_be_transient = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
        --
        -- local function make_transient_keymap(key, transient_key)
        --   maps.n[key] = {
        --     function()
        --       maps_clone.n[key][1]()
        --       require("which-key").show {
        --         keys = transient_key,
        --         loop = false,
        --       }
        --     end,
        --   }
        --
        --   maps.n[transient_key] = {
        --     function() end,
        --     desc = "Enter transient mode",
        --   }
        --
        --   maps.n[transient_key .. "]"] = {
        --     function()
        --       maps_clone.n[key][1]()
        --       require("which-key").show {
        --         keys = transient_key,
        --         loop = false,
        --       }
        --     end,
        --     desc = maps_clone.n[key].desc,
        --   }
        --
        --   maps.n[transient_key .. "["] = {
        --     function()
        --       maps_clone.n[key][1]()
        --       require("which-key").show {
        --         keys = transient_key,
        --         loop = false,
        --       }
        --     end,
        --     desc = maps_clone.n[key].desc,
        --   }
        -- end
        --
        -- make_transient_keymap("]t", "<leader><F1>t")
        -- maps.n["]b"] = {
        --   function()
        --     maps_clone.n["]b"][1]()
        --     require("which-key").show {
        --       keys = "<leader><F1>b",
        --       loop = false,
        --     }
        --   end,
        -- }
        --
        -- maps.n["<leader><F1>b"] = {
        --   function() end,
        --   desc = "Enter buffer persist mode",
        -- }
        -- maps.n["<leader><F1>b]"] = {
        --   function()
        --     maps_clone.n["]b"][1]()
        --     require("which-key").show {
        --       keys = "<leader><F1>b",
        --       loop = false, -- this will keep the popup open until you hit <esc>
        --     }
        --   end,
        --   desc = maps_clone.n["]b"].desc,
        -- }
        -- maps.n["<leader><F1>b["] = {
        --   function()
        --     maps_clone.n["[b"][1]()
        --     require("which-key").show {
        --       keys = "<leader><F1>b",
        --       loop = false, -- this will keep the popup open until you hit <esc>
        --     }
        --   end,
        --   desc = maps_clone.n["[b"].desc,
        -- }
        -- #endregion

        maps.n["<C-w><Space>"] = {
          function()
            require("which-key").show {
              keys = "<c-w>",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
          desc = "Enter window persist mode",
        }

        maps.n["z<Space>"] = {
          function()
            require("which-key").show {
              keys = "z",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
          desc = "Enter fold persist mode",
        }
        maps.n["zh"] = {
          function()
            vim.cmd "normal! 3zh"
            require("which-key").show {
              keys = "z",
              -- loop = true,
            }
          end,
        }
        maps.n["zl"] = {
          function()
            vim.cmd "normal! 3zl"
            require("which-key").show {
              keys = "z",
              -- loop = true,
            }
          end,
        }

        maps.n["<C-_>"] = {
          function() require("which-key").show { global = false } end,
          desc = "Buffer Keymaps (which-key)",
        }
        maps.i["<C-_>"] = maps.n["<C-_>"]
        maps.x["<C-_>"] = maps.n["<C-_>"]

        local wk = require "which-key"
        wk.add {
          {
            "<Leader>b",
            group = "buffers",
            expand = function() return require("which-key.extras").expand.buf() end,
          },
        }
        maps.n["<Leader>b"] = false
      end,
    },
  },
}
