---@type LazySpec
return {
  "folke/which-key.nvim",
  ---@class wk.Opts
  opts = function(_, opts)
    opts.preset = "helix"
    opts.delay = 100
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts) -- Configure core features of AstroNvim
        -- persist mode
        local maps = assert(opts.mappings)
        maps.n["<Leader>d."] = {
          function()
            require("which-key").show {
              keys = "<leader>d",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
          desc = "enter debug persist mode",
        }
        maps.n["]."] = {
          function()
            require("which-key").show {
              keys = "]",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
        }

        maps.n["[."] = {
          function()
            require("which-key").show {
              keys = "[",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
        }

        -- local original = maps.n["[b"][1]
        -- maps.n["[b"] = {
        --   function()
        --     original()
        --     require("which-key").show {
        --       keys = "[",
        --       loop = true, -- this will keep the popup open until you hit <esc>
        --     }
        --   end,
        -- }

        maps.n["<C-w><space>"] = {
          function()
            require("which-key").show {
              keys = "<c-w>",
              loop = true, -- this will keep the popup open until you hit <esc>
            }
          end,
          desc = "Enter window persist mode",
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
      end,
    },
  },
}
