---@type LazySpec
return {
  "xvzc/chezmoi.nvim",
  enabled = vim.fn.has "win32" ~= 1,
  config = function()
    require("chezmoi").setup {
      -- your configurations
    }
  end,
  opts = function(_, opts)
    --  e.g. ~/.local/share/chezmoi/*
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { os.getenv "HOME" .. "/.local/share/chezmoi/*" },
      callback = function(ev)
        local bufnr = ev.buf
        local edit_watch = function() require("chezmoi.commands.__edit").watch(bufnr) end
        vim.schedule(edit_watch)
      end,
    })
  end,
  specs = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope.nvim",
      optional = true,
      opts = function(_, opts)
        -- telscope-config.lua
        local telescope = require "telescope"
        telescope.load_extension "chezmoi"
      end,
      keys = {
        {
          "<leader>hc",
          function() require("telescope").extensions.chezmoi.find_files() end,
          mode = { "n" },
          desc = "Config/Chezmoi files",
        },
      },
    },
    {
      "fzf.lua",
      optional = true,
      opts = function()
        fzf_chezmoi = function()
          require("fzf-lua").fzf_exec(require("chezmoi.commands").list(), {
            actions = {
              ["default"] = function(selected, opts)
                require("chezmoi.commands").edit {
                  targets = { "~/" .. selected[1] },
                  args = { "--watch" },
                }
              end,
            },
          })
        end

        vim.api.nvim_create_user_command("ChezmoiFzf", fzf_chezmoi, {})
      end,
    },
  },
}
