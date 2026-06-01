local chezmoiRoot = vim.fs.normalize "~/.local/share/chezmoi"
---@type LazySpec
return {
  {
    "alker0/chezmoi.vim",
    lazy = false,
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      vim.g["chezmoi#use_external"] = 1
    end,
  },
  {
    "xvzc/chezmoi.nvim",
    event = { "BufRead", "BufNewFile" },
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
    keys = {
      {
        "<leader>hc",
        function()
          require("chezmoi.pick").snacks(nil, {
            "--path-style",
            "absolute",
            "--exclude",
            "externals",
            "--exclude",
            "dirs",
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("my.chezmoi", { clear = false }),
        pattern = { chezmoiRoot .. "/*" },
        callback = function() vim.schedule(require("chezmoi.commands.__edit").watch) end,
      })
    end,
  },
  {
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      file = {
        [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
        ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
        ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
      },
    },
  },
}
