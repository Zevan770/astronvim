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
  -- { import = "astrocommunity.recipes.heirline-nvchad-statusline" },

  -- fuzzy
  -- { import = "astrocommunity.fuzzy-finder.fzf-lua" },

  -- edit
  -- { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
  -- { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  --- force save file with sudo
  { import = "astrocommunity.editing-support.suda-vim" },

  -- motion/jump/navigation
  -- { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.tabout-nvim" },

  -- lsp
  -- { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },

  -- utility/tools/games
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.game.leetcode-nvim" },
  { import = "astrocommunity.docker.lazydocker" },
  -- { import = "astrocommunity.note-taking.venn-nvim" },

  { import = "astrocommunity.editing-support.refactoring-nvim" },
}

---@type LazySpec
return M
