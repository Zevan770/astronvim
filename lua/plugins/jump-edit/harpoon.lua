if true then return {} end
---@type LazySpec
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    { "AstroNvim/astroui", opts = { icons = { Harpoon = "󱡀" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local term_string = vim.fn.exists "$TMUX" == 1 and "tmux" or "term"
        local prefix = "<Leader><Leader>"
        maps.n[prefix] = { desc = require("astroui").get_icon("Harpoon", 1, true) .. "Harpoon" }

        maps.n[prefix .. "a"] = { function() require("harpoon"):list():add() end, desc = "Add file" }
        maps.n[prefix .. "e"] = {
          function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
          desc = "Toggle quick menu",
        }
        maps.n["<C-x>"] = {
          function()
            vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
              local num = tonumber(input)
              if num then require("harpoon"):list():select(num) end
            end)
          end,
          desc = "Goto index of mark",
        }
        maps.n["<C-H>"] = { function() require("harpoon"):list():prev() end, desc = "Goto previous mark" }
        maps.n["<C-L>"] = { function() require("harpoon"):list():next() end, desc = "Goto next mark" }
        maps.n[prefix .. "f"] = { "<Cmd>Telescope harpoon marks<CR>", desc = "Show marks in Telescope" }
        maps.n[prefix .. "t"] = {
          function()
            vim.ui.input({ prompt = term_string .. " window number: " }, function(input)
              local num = tonumber(input)
              if num then require("harpoon").term.gotoTerminal(num) end
            end)
          end,
          desc = "Go to " .. term_string .. " window",
        }
      end,
    },
  },
  specs = {
    {
      "rebelot/heirline.nvim",
      dependencies = "abeldekat/harpoonline",
      config = function(plugin, opts)
        local Status = require "astroui.status"
        local Harpoonline = require "harpoonline"
        Harpoonline.setup {
          on_update = function() vim.cmd.redrawstatus() end,
        }
        local HarpoonComponent = Status.component.builder {
          {
            provider = function()
              local line = Harpoonline.format()
              return Status.utils.stylize(line, { padding = { left = 1, right = 1 } })
            end,
            hl = function()
              if Harpoonline.is_buffer_harpooned() then return { bg = "command", fg = "bg" } end
            end,
          },
        }
        table.insert(opts.statusline, 4, HarpoonComponent) -- after file_info component
        require "astronvim.plugins.configs.heirline"(plugin, opts)
      end,
    },
  },
}
