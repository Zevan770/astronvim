-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- gui
  -- { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.recipes.neovide" },

  -- ui
  -- { import = "astrocommunity.recipes.vscode-icons" },
  -- { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.color.transparent-nvim" },
  -- { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- { import = "astrocommunity.scrolling.neoscroll-nvim" },
  -- { import = "astrocommunity.scrolling.mini-animate" },
  { import = "astrocommunity.split-and-window.minimap-vim" },
  { import = "astrocommunity.utility.noice-nvim" },

  -- ai/completion
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  -- { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.completion.cmp-cmdline" },

  -- remote
  { import = "astrocommunity.remote-development.distant-nvim" },
  -- import/override with your plugins folder

  -- fuzzy
  -- { import = "astrocommunity.fuzzy-finder.fzf-lua" },

  -- edit/motion/jump/navigation
  { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
  { import = "astrocommunity.editing-support.multiple-cursors-nvim" },
  -- { import = "astrocommunity.editing-support.undotree" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.flash-nvim" },
  -- { import = "astrocommunity.motion.hop-nvim" },
  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },

  -- key
  -- { import = "astrocommunity.keybinding.mini-clue"}

  -- lsp
  -- { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.lspsaga-nvim" },
  -- { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },

  -- utility/tools
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },

  -- lang
  --- lua
  { import = "astrocommunity.neovim-lua-development.lazydev-nvim" },
  { import = "astrocommunity.pack.lua" },

  -- markdown
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
}
