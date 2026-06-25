return {
  {
    "smoka7/multicursors.nvim",
    event = "User AstroFile",
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
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
      local mc = require "multicursor-nvim"
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<C-up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "x" }, "<C-down>", function() mc.lineAddCursor(1) end)
      set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<leader>mn", function() mc.matchAddCursor(1) end)
      -- set({ "n", "x" }, "<leader>mq", function() mc.matchSkipCursor(1) end)
      set({ "n", "x" }, "<leader>mN", function() mc.matchAddCursor(-1) end)
      -- set({ "n", "x" }, "<leader>mQ", function() mc.matchSkipCursor(-1) end)

      -- Pressing `<leader>miwap` will create a cursor in every match of the
      -- string captured by `iw` inside range `ap`.
      -- This action is highly customizable, see `:h multicursor-operator`.
      set({ "n", "x" }, "<leader>mm", mc.operator)
      set({ "x" }, "<leader>mv", mc.visualToCursors)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<leader>m<leader>", mc.toggleCursor)
      -- match new cursors within visual selections by regex.
      -- set("x", "M", mc.matchCursors)
      set("x", "I", mc.insertVisual)
      set("x", "A", mc.appendVisual)
      set("x", "gz", mc.splitCursors)

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
        layerSet("n", "M", function() mc.toggleCursor() end)

        layerSet("n", "ga", mc.alignCursors, { nowait = true })
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
    event = "User AstroFile",
    dependencies = {
      "jake-stewart/multicursor.nvim",
    },
    config = function()
      local mcos = require "mcos"
      mcos.setup {}

      -- mcos doesn't setup any keymaps
      -- here are some recommended ones
      vim.keymap.set({ "n", "v" }, "<leader>ms", mcos.opkeymapfunc, { expr = true })
      vim.keymap.set({ "n" }, "<leader>mss", mcos.bufkeymapfunc)
    end,
  },
}
