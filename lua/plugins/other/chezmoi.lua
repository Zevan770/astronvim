local chezmoiRoot = vim.fs.normalize "~/.local/share/chezmoi"
---@type LazySpec
return {
  {
    "alker0/chezmoi.vim",
    lazy = false,
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              ["chezmoi#use_tmp_buffer"] = 1,
              ["chezmoi#use_external"] = 1,
              -- ["chezmoi#source_dir_path"] = chezmoiRoot
            },
          },
        },
      },
    },
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
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          autocmds = {
            chezmoi = {
              {
                event = { "BufRead", "BufNewFile" },
                pattern = { chezmoiRoot .. "/*" },
                callback = function() vim.schedule(require("chezmoi.commands.__edit").watch) end,
              },
            },
          },
        },
      },
    },
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
