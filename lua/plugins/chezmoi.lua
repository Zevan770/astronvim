---@type LazySpec
-- Lazy.nvim
return {
  "xvzc/chezmoi.nvim",
  dependencies = { "nvim-lua/plenary.nvim", { "telescope.nvim", optional = true } },
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
}
