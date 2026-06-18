-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.
local M = {
  "AstroNvim/astrocommunity",

  -- gui
  { import = "astrocommunity.recipes.neovide" },

  -- ui
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },

  -- motion/jump/navigation
  -- { import = "astrocommunity.motion.tabout-nvim" },

  -- lsp
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },

  -- utility/tools/games
  -- { import = "astrocommunity.docker.lazydocker" },
  -- { import = "astrocommunity.note-taking.venn-nvim" },

  { import = "astrocommunity.editing-support.refactoring-nvim" },
}

---@type LazySpec
return M
