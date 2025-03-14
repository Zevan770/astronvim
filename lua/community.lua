-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.
local M = {
  "AstroNvim/astrocommunity",

  -- gui
  { import = "astrocommunity.recipes.neovide" },

  -- ui
  { import = "astrocommunity.split-and-window.minimap-vim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  -- { import = "astrocommunity.editing-support.zen-mode-nvim" },

  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.quickfix.quicker-nvim" },

  -- color
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  -- { import = "astrocommunity.color.huez-nvim" },

  -- fuzzy
  -- { import = "astrocommunity.fuzzy-finder.fzf-lua" },

  -- edit
  -- { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
  -- { import = "astrocommunity.file-explorer.mini-files" },
  -- { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  --- force save file with sudo
  { import = "astrocommunity.editing-support.suda-vim" },

  -- motion/jump/navigation
  -- { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.motion.tabout-nvim" },

  -- lsp
  -- { import = "astrocommunity.lsp.lsp-signature-nvim" },

  -- utility/tools/games
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.game.leetcode-nvim" },
  { import = "astrocommunity.docker.lazydocker" },
  { import = "astrocommunity.programming-language-support.csv-vim" },
  -- { import = "astrocommunity.note-taking.venn-nvim" },
}

---@type LazySpec
return M
