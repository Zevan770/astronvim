---@type LazySpec
return {
  "xvzc/chezmoi.nvim",
  enabled = vim.fn.has "win32" ~= 1,
  opts = {
    edit = {
      watch = true,
      force = false,
    },
    notification = {
      on_open = true,
      on_apply = true,
      on_watch = true,
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        autocmds = {
          chezmoi = {
            {
              event = { "BufRead", "BufNewFile" },
              pattern = { os.getenv "HOME" .. "/.local/share/chezmoi/*" },
              callback = function() vim.schedule(require("chezmoi.commands.__edit").watch) end,
            },
          },
        },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      optional = true,
      dependencies = {
        "xvzc/chezmoi.nvim",
        {
          "AstroNvim/astrocore",
          opts = {
            mappings = {
              n = {
                ["<Leader>hc"] = {
                  function() require("telescope").extensions.chezmoi.find_files() end,
                  desc = "Find chezmoi config",
                },
              },
            },
          },
        },
      },
      opts = function() require("telescope").load_extension "chezmoi" end,
    },
    {
      "ibhagwan/fzf-lua",
      optional = true,
      dependencies = {
        {
          "AstroNvim/astrocore",
          ---@type AstroCoreOpts
          opts = {
            commands = {
              ChezmoiFzf = {
                function()
                  require("fzf-lua").fzf_exec(require("chezmoi.commands").list(), {
                    actions = {
                      ["default"] = function(selected, _)
                        require("chezmoi.commands").edit {
                          targets = { "~/" .. selected[1] },
                          args = { "--watch" },
                        }
                      end,
                    },
                  })
                end,
                desc = "Search Chezmoi configuration with FZF",
              },
            },
            mappings = {
              n = {
                ["<Leader>hc"] = {
                  function() vim.cmd.ChezmoiFzf() end,
                  desc = "Find chezmoi config",
                },
              },
            },
          },
        },
      },
    },
  },
}
