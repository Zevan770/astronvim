return {
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = { "nvimtools/hydra.nvim" },
    config = true,
    opts = {},
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<Cmd>MCstart<CR>",
        desc = "Create a selection for word under the cursor",
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    enabled = false,
    event = { "User AstroFile", "InsertEnter" },
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts astrocoreopts
      opts = function(_, opts)
        if not opts.autocmds then opts.autocmds = {} end
        opts.autocmds.visual_multi_exit = {
          {
            event = "User",
            pattern = "visual_multi_exit",
            desc = "Avoid spurious 'hit-enter-prompt' when exiting vim-visual-multi",
            callback = function()
              vim.o.cmdheight = 1
              vim.schedule(function() vim.o.cmdheight = opts.options.opt.cmdheight end)
            end,
          },
        }

        if not opts.options then opts.options = {} end
        if not opts.options.g then opts.options.g = {} end
        local g = assert(opts.options.g)

        g.VM_silent_exit = 1
        g.VM_show_warnings = 0
        g.VM_leader = "<Leader>v"

        if not opts.options.g.VM_maps then opts.options.g.VM_maps = {} end
        local vm_maps = assert(opts.options.g.VM_maps)
        vm_maps["Undo"] = "u"
        vm_maps["Redo"] = "U"

        if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
        local maps = assert(opts.mappings)
        maps.n["<C-A-K>"] = { "<Cmd>call vm#commands#add_cursor_up(0, v:count1)<cr>", desc = "Add cursor above" }
        maps.n["<C-A-J>"] = { "<Cmd>call vm#commands#add_cursor_down(0, v:count1)<cr>", desc = "Add cursor below" }
      end,
      -- keys = {
      --   {
      --     "<c-k>",
      --     function() vim.cmd "call vm#commands#add_cursor_up(0, v:count1)" end,
      --     desc = "Add cursor above",
      --     mode = { "n", "v" },
      --   },
      --   {
      --     "<c-J>",
      --     function() vim.cmd "call vm#commands#add_cursor_down(0, v:count1)" end,
      --     desc = "Add cursor below",
      --     mode = { "n", "v" },
      --   },
      -- },
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "User AstroFile",
    config = function()
      local mc = require "multicursor-nvim"
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
      set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "gmn", function() mc.matchAddCursor(1) end)
      set({ "n", "x" }, "gmq", function() mc.matchSkipCursor(1) end)
      set({ "n", "x" }, "gmN", function() mc.matchAddCursor(-1) end)
      set({ "n", "x" }, "gmQ", function() mc.matchSkipCursor(-1) end)

      -- Pressing `<leader>miwap` will create a cursor in every match of the
      -- string captured by `iw` inside range `ap`.
      -- This action is highly customizable, see `:h multicursor-operator`.
      set({ "n", "x" }, "gmm", mc.operator)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<leader>m", mc.toggleCursor)
      -- match new cursors within visual selections by regex.
      set("x", "M", mc.matchCursors)
      set("x", "I", mc.insertVisual)
      set("x", "A", mc.appendVisual)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
        layerSet("n", "m", function() mc.toggleCursor() end)

        layerSet("n", "gma", mc.alignCursors, { nowait = true })
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
  {
    "zaucy/mcos.nvim",
    event = "VeryLazy",
    dependencies = {
      "jake-stewart/multicursor.nvim",
    },
    config = function()
      local mcos = require "mcos"
      mcos.setup {}

      -- mcos doesn't setup any keymaps
      -- here are some recommended ones
      vim.keymap.set({ "n", "v" }, "gms", mcos.opkeymapfunc, { expr = true })
      vim.keymap.set({ "n" }, "gmss", mcos.bufkeymapfunc)
    end,
  },
}
