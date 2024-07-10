-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- gui
  { import = "astrocommunity.recipes.neovide" },

  -- ui
  -- { import = "astrocommunity.recipes.vscode-icons" },
  -- { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- { import = "astrocommunity.scrolling.neoscroll-nvim" },
  -- { import = "astrocommunity.scrolling.mini-animate" },
  { import = "astrocommunity.split-and-window.minimap-vim" },
  -- { import = "astrocommunity.split-and-window.edgy-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- color
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- ai/completion
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- remote
  { import = "astrocommunity.remote-development.distant-nvim" },
  -- import/override with your plugins folder

  -- fuzzy
  -- { import = "astrocommunity.fuzzy-finder.fzf-lua" },

  -- edit
  { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
  -- { import = "astrocommunity.editing-support.multiple-cursors-nvim" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.syntax.hlargs-nvim" },

  -- motion/jump/navigation
  { import = "astrocommunity.motion.flash-nvim" },
  -- { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.mini-ai" },

  -- key

  -- lsp
  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
  -- { import = "astrocommunity.lsp.lspsaga-nvim" },
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },

  -- debug
  { import = "astrocommunity.debugging.nvim-bqf" },

  -- version control/git
  { import = "astrocommunity.git.neogit" },

  -- utility/tools/games
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
  { import = "astrocommunity.game.leetcode-nvim" },

  -- lang

  --- c
  { import = "astrocommunity.pack.cpp" },

  --- python
  -- { import = "astrocommunity.pack.python" },

  --- powershell
  { import = "astrocommunity.pack.ps1" },

  --- json
  { import = "astrocommunity.pack.json" },

  --- java
  -- { import = "astrocommunity.pack.java" },

  --- lua
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.neovim-lua-development.lazydev-nvim" },

  -- markdown
  { import = "astrocommunity.pack.markdown" },
  -- { import = "astrocommunity.markdown-and-latex.glow-nvim" },
}
