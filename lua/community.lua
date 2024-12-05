-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.
local M = {
  "AstroNvim/astrocommunity",

  -- gui
  { import = "astrocommunity.recipes.neovide" },

  -- ui
  -- { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- { import = "astrocommunity.scrolling.mini-animate" },
  -- { import = "astrocommunity.scrolling.vim-smoothie" },
  -- { import = "astrocommunity.scrolling.cinnamon-nvim" },
  { import = "astrocommunity.split-and-window.minimap-vim" },
  -- { import = "astrocommunity.split-and-window.edgy-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  -- { import = "astrocommunity.search.nvim-spectre" },
  -- { import = "astrocommunity.indent.indent-rainbowline" },
  -- this plugin is too annoying
  -- { import = "astrocommunity.editing-support.nvim-context-vt" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },

  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.quickfix.quicker-nvim" },

  -- color
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },

  -- remote
  -- import/override with your plugins folder

  -- fuzzy
  -- { import = "astrocommunity.fuzzy-finder.fzf-lua" },

  -- edit
  -- { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
  -- { import = "astrocommunity.file-explorer.mini-files" },
  --
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  -- { import = "astrocommunity.syntax.hlargs-nvim" },
  -- { import = "astrocommunity.editing-support.vim-visual-multi" },
  --- force save file with sudo
  { import = "astrocommunity.editing-support.suda-vim" },

  -- motion/jump/navigation
  -- { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.motion.tabout-nvim" },

  -- project
  -- { import = "astrocommunity.motion.harpoon" },
  -- { import = "astrocommunity.project.neoconf-nvim" },

  -- lsp
  { import = "astrocommunity.lsp.lsp-signature-nvim" },

  -- utility/tools/games
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
  { import = "astrocommunity.game.leetcode-nvim" },
}

---@type LazySpec
return M
