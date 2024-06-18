if not vim.g.vscode then return {} end -- don't do anything in non-vscode instances

local enabled = {}
vim.tbl_map(function(plugin) enabled[plugin] = true end, {
  -- core plugins
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "Comment.nvim",
  "nvim-autopairs",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  -- more known working
  "dial.nvim",
  "flash.nvim",
  "flit.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  "mini.move",
  "mini.pairs",
  "mini.surround",
  "ts-comments.nvim",
  "vim-easy-align",
  "vim-repeat",
  "vim-sandwich",
  "vscode-multi-cursor",
  "yanky.nvim",
  -- feel free to open PRs to add more support!
  "flash-zh.nvim",
  "im-select.nvim",
})

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return enabled[plugin.name] end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)

      -- Motion: basic move
      maps.n["k"] = function() vim.cmd "normal gk" end
      maps.x["k"] = function() vim.cmd "normal gk" end
      maps.n["j"] = function() vim.cmd "normal gj" end
      maps.x["j"] = function() vim.cmd "normal gj" end
      maps.n["<Space>"] = false
      maps.v["<Space>"] = function() require("vscode-neovim").action "vspacecode.space" end
      maps.v[","] = function() require("vscode-neovim").action "vspacecode.space" end
      maps.v["m]"] = function() require("vscode-neovim").action "bookmarks.expandSelectionToNext" end
      maps.v["m["] = function() require("vscode-neovim").action "bookmarks.expandSelectionToPrevious" end
      maps.v["3s"] = function() require("vscode-neovim").action "metaGo.selectAfter" end
      maps.v["2s"] = function() require("vscode-neovim").action "metaGo.selectSmart" end
      -- maps.v["s"] = function() require("vscode-neovim").action "metaGo.selectBefore" end
      maps.v["ig"] = function() require("vscode-neovim").action "regionfolder.selectCurrentRegionContents" end
      maps.v["ag"] = function() require("vscode-neovim").action "regionfolder.selectCurrentRegion" end
      maps.v["Sg"] = function() require("vscode-neovim").action "macros.vim.Sr" end

      maps.n["<Space>"] = function() require("vscode-neovim").action "vspacecode.space" end
      maps.n["'"] = "`"
      maps.n["mn"] = function() require("vscode-neovim").action "bookmarks.toggleLabeled" end
      maps.n["mc"] = function() require("vscode-neovim").action "bookmarks.clear" end
      maps.n["mC"] = function() require("vscode-neovim").action "bookmarks.clearFromAllFiles" end
      maps.n["ml"] = function() require("vscode-neovim").action "bookmarks.list" end
      maps.n["mL"] = function() require("vscode-neovim").action "bookmarks.listFromAllFiles" end
      maps.n["'n"] = function() require("vscode-neovim").action "bookmarks.jumpToNext" end
      maps.n["'N"] = function() require("vscode-neovim").action "bookmarks.jumpToPrevious" end
      -- maps.n["m"] = function() require("vscode-neovim").action "bookmarks.toggle" end
      maps.n["gc;"] = "gcc"
      -- maps.n["u"] = function() require("vscode-neovim").action "undo" end
      -- maps.n["<C-r>"] = function() require("vscode-neovim").action "redo" end
      -- maps.n["U"] = function() require("vscode-neovim").action "redo" end
      maps.n["gl"] = function() require("vscode-neovim").action "metaGo.addCursorBefore" end

      -- maps.n["s"] = function() require("vscode-neovim").action "metaGo.gotoBefore" end
      maps.n["2s"] = function() require("vscode-neovim").action "metaGo.gotoAfter" end
      maps.n["3s"] = function() require("vscode-neovim").action "metaGo.gotoSmart" end

      -- -- basic actions
      -- maps.n["<Leader>q"] = function() require("vscode-neovim").action "workbench.action.closeWindow" end
      -- maps.n["<Leader>w"] = function() require("vscode-neovim").action "workbench.action.files.save" end
      -- maps.n["<Leader>n"] = function() require("vscode-neovim").action "welcome.showNewFileEntries" end
      --
      -- -- splits navigation
      -- maps.n["|"] = function() require("vscode-neovim").action "workbench.action.splitEditor" end
      -- maps.n["\\"] = function() require("vscode-neovim").action "workbench.action.splitEditorDown" end
      maps.n["<C-H>"] = function() require("vscode-neovim").action "workbench.action.navigateLeft" end
      maps.n["<C-J>"] = function() require("vscode-neovim").action "workbench.action.navigateDown" end
      maps.n["<C-K>"] = function() require("vscode-neovim").action "workbench.action.navigateUp" end
      maps.n["<C-L>"] = function() require("vscode-neovim").action "workbench.action.navigateRight" end
      --
      -- -- terminal
      -- maps.n["<F7>"] = function() require("vscode-neovim").action "workbench.action.terminal.toggleTerminal" end
      -- maps.n["<C-'>"] = function() require("vscode-neovim").action "workbench.action.terminal.toggleTerminal" end
      --
      -- -- buffer management
      maps.n["]b"] = "<Cmd>Tabnext<CR>"
      maps.n["[b"] = "<Cmd>Tabprevious<CR>"
      -- maps.n["<Leader>c"] = "<Cmd>Tabclose<CR>"
      -- maps.n["<Leader>C"] = "<Cmd>Tabclose!<CR>"
      -- maps.n["<Leader>bp"] = "<Cmd>Tablast<CR>"
      --
      -- -- file explorer
      -- maps.n["<Leader>ae"] = function() require("vscode-neovim").action "workbench.files.action.focusFilesExplorer" end
      -- maps.n["<Leader>o"] = function() require("vscode-neovim").action "workbench.files.action.focusFilesExplorer" end
      --
      -- -- indentation
      maps.v["<Tab>"] = function() require("vscode-neovim").action "editor.action.indentLines" end
      maps.v["<S-Tab>"] = function() require("vscode-neovim").action "editor.action.outdentLines" end
      --
      -- -- diagnostics
      -- maps.n["]d"] = function() require("vscode-neovim").action "editor.action.marker.nextInFiles" end
      -- maps.n["[d"] = function() require("vscode-neovim").action "editor.action.marker.prevInFiles" end
      --
      -- -- pickers (emulate telescope mappings)
      -- maps.n["<Leader>fc"] = function()
      --   require("vscode-neovim").action("workbench.action.findInFiles", { args = { query = vim.fn.expand "<cword>" } })
      -- end
      -- maps.n["<Leader>fC"] = function() require("vscode-neovim").action "workbench.action.showCommands" end
      -- maps.n["<Leader>ff"] = function() require("vscode-neovim").action "workbench.action.quickOpen" end
      -- maps.n["<Leader>fn"] = function() require("vscode-neovim").action "notifications.showList" end
      -- maps.n["<Leader>fo"] = function() require("vscode-neovim").action "workbench.action.openRecent" end
      -- maps.n["<Leader>ft"] = function() require("vscode-neovim").action "workbench.action.selectTheme" end
      -- maps.n["<Leader>fw"] = function() require("vscode-neovim").action "workbench.action.findInFiles" end
      --
      -- -- git client
      -- maps.n["<Leader>gg"] = function() require("vscode-neovim").action "workbench.view.scm" end
      --
      -- -- LSP Mappings
      maps.n["K"] = function() require("vscode-neovim").action "editor.action.showHover" end
      maps.n["gI"] = function() require("vscode-neovim").action "editor.action.goToImplementation" end
      maps.n["gd"] = function() require("vscode-neovim").action "editor.action.revealDefinition" end
      maps.n["gD"] = function() require("vscode-neovim").action "editor.action.revealDeclaration" end
      maps.n["gr"] = function() require("vscode-neovim").action "editor.action.goToReferences" end
      maps.n["gy"] = function() require("vscode-neovim").action "editor.action.goToTypeDefinition" end
      maps.n["<Leader>la"] = function() require("vscode-neovim").action "editor.action.quickFix" end
      maps.n["<Leader>lG"] = function() require("vscode-neovim").action "workbench.action.showAllSymbols" end
      maps.n["<Leader>lR"] = function() require("vscode-neovim").action "editor.action.goToReferences" end
      maps.n["<Leader>lr"] = function() require("vscode-neovim").action "editor.action.rename" end
      maps.n["<Leader>ls"] = function() require("vscode-neovim").action "workbench.action.gotoSymbol" end
      maps.n["<Leader>lf"] = function() require("vscode-neovim").action "editor.action.formatDocument" end
    end,
  },
  -- disable colorscheme setting
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  -- disable treesitter highlighting
  { "nvim-treesitter/nvim-treesitter", opts = { highlight = { enable = false } } },
}
