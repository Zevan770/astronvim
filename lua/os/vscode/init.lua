if not vim.g.vscode then return {} end -- don't do anything in non-vscode instances

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.opt.relativenumber = true
    vim.opt.cmdheight = 2
  end,
})
local enabled = {}
vim.tbl_map(function(plugin) enabled[plugin] = true end, {
  -- core plugins
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "Comment.nvim",
  "nvim-autopairs",
  "coerce.nvim",
  "coop.nvim",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-various-textobjs",
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
  "mini.splitjoin",
  "treesj",
  "gx.nvim",
  "substitute.nvim",
  "nvim-spider",
  "sibling-swap.nvim",
  "quicker.nvim",
  "ts-comments.nvim",
  "treewalker.nvim",
  "vim-easy-align",
  "vim-repeat",
  "vim-sandwich",
  "vscode-multi-cursor",
  "vim-matchup",
  "yanky.nvim",
  "catppuccin",
  -- feel free to open PRs to add more support!
  "flash-zh.nvim",
  "im-select.nvim",
  "fast-cursor-move.nvim",
  -- "which-key.nvim",
})

local Config = require "lazy.core.config"
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin) return enabled[plugin.name] end

local vscode = require "vscode"
vim.notify = vscode.notify

-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   callback = function() vscode.action "errorLens.disableLine" end,
-- })

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    --@param opts AstroCoreOpts
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local maps = assert(opts.mappings)

      -- Motion: basic move
      maps.n["j"] = function()
        if not vim.v.count == 0 then
          vim.cmd(string.format("normal! %dj", vim.v.count))
        else
          vim.cmd "normal gj"
        end
      end
      maps.n["k"] = function()
        if not vim.v.count == 0 then
          vim.cmd(string.format("normal! %dk", vim.v.count))
        else
          vim.cmd [[call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count1 })]]
        end
      end

      local function wrappedLine_move(d)
        return function()
          -- Only works in charwise visual mode
          if vim.api.nvim_get_mode().mode ~= "v" then return "g" .. d end
          require("vscode-neovim").action("cursorMove", {
            args = {
              {
                to = d == "j" and "down" or "up",
                by = "wrappedLine",
                value = vim.v.count1,
                select = true,
              },
            },
          })
          return "<Ignore>"
        end
      end

      maps.x["gj"] = { function() wrappedLine_move "j" end, expr = true }
      maps.x["gk"] = { function() wrappedLine_move "k" end, expr = true }

      -- vspacecode
      local vspacecode_with_restore_im = function()
        vscode.call "vspacecode.space"
        require("im_select").restore_default_im()
      end

      maps.n["<Space>"] = vspacecode_with_restore_im
      maps.x["<Space>"] = vspacecode_with_restore_im

      maps.n[","] = function()
        vscode.call "vspacecode.space"
        vscode.call("whichkey.triggerKey", {
          args = {
            "m",
          },
        })
        require("im_select").restore_default_im()
      end
      maps.x[","] = maps.n[","]
      maps.x["m]"] = function() vscode.action "bookmarks.expandSelectionToNext" end
      maps.x["m["] = function() vscode.action "bookmarks.expandSelectionToPrevious" end

      -- maps.x["3s"] = function() vscode.action "metaGo.selectAfter" end
      -- maps.x["2s"] = function() vscode.action "metaGo.selectSmart" end
      -- maps.x["s"] = function() vscode.action "metaGo.selectBefore" end
      -- maps.n["gl"] = function() vscode.action "metaGo.addCursorBefore" end
      -- maps.n["s"] = function() vscode.action "metaGo.gotoBefore" end
      -- maps.n["2s"] = function() vscode.action "metaGo.gotoAfter" end
      -- maps.n["3s"] = function() vscode.action "metaGo.gotoSmart" end

      -- folding
      -- maps.x["zf"] = function()
      --   vscode.call "editor.createFoldingRangeFromSelection"
      --   -- backto normal mode and move down
      --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>j", true, true, true), "n", true)
      -- end
      -- maps.n["zf"] = function()
      --   -- enter visual mode and wait for motion
      --   vim.api.nvim_feedkeys("v", "n", false)
      --   -- create folding range from selection
      --   vim.api.nvim_create_autocmd("CursorMoved", {
      --     once = true,
      --     -- should after vscode.cursor autocmd
      --
      --     callback = function()
      --       vim.notify "hello"
      --       vscode.call "editor.createFoldingRangeFromSelection"
      --       -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "n", true)
      --     end,
      --   })
      -- end

      local esc = function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "n", false)
      end
      local create_fold = vscode.to_op(
        function(ctx) vscode.action("editor.createFoldingRangeFromSelection", { range = ctx.range, callback = esc }) end
      )
      maps.n["zf"] = { create_fold, expr = true }
      maps.x["zf"] = maps.n["zf"]

      maps.n["zd"] = function() vscode.action "editor.removeManualFoldingRanges" end
      maps.n["zc"] = function()
        vscode.call "editor.fold"
        vim.cmd.normal "^"
      end
      maps.n["zC"] = function()
        vscode.call "editor.foldRecursively"
        vim.cmd.normal "^"
      end
      maps.n["zo"] = function() vscode.action "editor.unfold" end
      maps.n["zO"] = function() vscode.action "editor.unfoldRecursively" end
      maps.n["za"] = { function() vscode.action "editor.toggleFold" end, desc = "toggle fold" }
      maps.n["zM"] = { function() vscode.action "editor.foldAll" end, desc = "fold all" }
      maps.n["zR"] = { function() vscode.action "editor.unfoldAll" end, desc = "unfold all" }

      -- region
      maps.x["ir"] = function() vscode.action "regionfolder.selectCurrentRegionContents" end
      maps.o["ir"] = maps.x["ir"]
      maps.x["ar"] = function() vscode.action "regionfolder.selectCurrentRegion" end
      maps.o["ar"] = maps.x["ar"]
      maps.x["gsar"] = function()
        vscode.with_insert(function() vscode.action "regionfolder.wrapWithRegion" end)
      end
      maps.n["gsdr"] = function() vscode.action "regionfolder.deleteCurrentRegion" end

      maps.n["'"] = "`"
      maps.n["ma"] = function() vscode.action "bookmarks.toggleLabeled" end
      maps.n["dma"] = function() vscode.action "bookmarks.clear" end
      maps.n["dmA"] = function() vscode.action "bookmarks.clearFromAllFiles" end
      maps.n["ml"] = function() vscode.action "bookmarks.list" end
      maps.n["mL"] = function() vscode.action "bookmarks.listFromAllFiles" end
      maps.n["m"] = { "<Cmd>lua require('vscode').action('bookmarks.toggle')<CR>m" }
      maps.n["]'"] = function() vscode.action "bookmarks.jumpToNext" end
      maps.n["['"] = function() vscode.action "bookmarks.jumpToPrevious" end
      -- maps.n["m"] = function() vscode.action "bookmarks.toggle" end
      maps.n["gc;"] = "gcc"
      maps.n["u"] = function() vscode.action "undo" end
      maps.n["<C-r>"] = function() vscode.action "redo" end
      maps.n["U"] = function() vscode.action "redo" end

      -- -- basic actions
      -- maps.n["<Leader>q"] = function() vscode.action "workbench.action.closeWindow" end
      -- maps.n["<Leader>w"] = function() vscode.action "workbench.action.files.save" end
      -- maps.n["<Leader>n"] = function() vscode.action "welcome.showNewFileEntries" end
      --
      -- -- splits navigation
      -- maps.n["|"] = function() vscode.action "workbench.action.splitEditor" end
      -- maps.n["\\"] = function() vscode.action "workbench.action.splitEditorDown" end
      -- maps.n["<C-H>"] = function() vscode.action "workbench.action.navigateLeft" end
      -- maps.n["<C-J>"] = function() vscode.action "workbench.action.navigateDown" end
      -- maps.n["<C-K>"] = function() vscode.action "workbench.action.navigateUp" end
      -- maps.n["<C-L>"] = function() vscode.action "workbench.action.navigateRight" end
      --
      -- -- terminal
      -- maps.n["<F7>"] = function() vscode.action "workbench.action.terminal.toggleTerminal" end
      -- maps.n["<C-'>"] = function() vscode.action "workbench.action.terminal.toggleTerminal" end
      --
      -- -- buffer management
      maps.n["]b"] = "<Cmd>Tabnext<CR>"
      maps.n["[b"] = "<Cmd>Tabprevious<CR>"
      maps.n["<Leader><Tab>"] = "<Cmd>Tablast<CR>"
      --
      -- -- indentation
      maps.x["<Tab>"] = function() vscode.action "editor.action.indentLines" end
      maps.x["<S-Tab>"] = function() vscode.action "editor.action.outdentLines" end
      -- -- LSP Mappings
      -- maps.n["K"] = function() vscode.action "editor.action.showHover" end
      maps.n["gk"] = function() vscode.action "editor.action.showHover" end
      maps.n["gI"] = function() vscode.action "editor.action.goToImplementation" end
      maps.n["gd"] = function() vscode.action "editor.action.revealDefinition" end
      maps.n["gD"] = function() vscode.action "editor.action.revealDeclaration" end
      maps.n["gr"] = function() vscode.action "editor.action.goToReferences" end
      maps.n["gy"] = function() vscode.action "editor.action.goToTypeDefinition" end
      -- maps.n["<Leader>la"] = function() vscode.action "editor.action.quickFix" end
      -- maps.n["<Leader>lG"] = function() vscode.action "workbench.action.showAllSymbols" end
      -- maps.n["<Leader>lR"] = function() vscode.action "editor.action.goToReferences" end
      -- maps.n["<Leader>lr"] = function() vscode.action "editor.action.rename" end
      -- maps.n["<Leader>ls"] = function() vscode.action "workbench.action.gotoSymbol" end
      -- maps.n["<Leader>lf"] = function() vscode.action "editor.action.formatDocument" end
    end,
  },
  -- disable colorscheme setting
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  -- disable treesitter highlighting
  { "nvim-treesitter/nvim-treesitter", opts = { highlight = { enable = false } } },
}
