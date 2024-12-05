return {
  "mg979/vim-visual-multi",
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
      maps.n["<C-K>"] = { "<Cmd>call vm#commands#add_cursor_up(0, v:count1)<cr>", desc = "Add cursor above" }
      maps.n["<C-J>"] = { "<Cmd>call vm#commands#add_cursor_down(0, v:count1)<cr>", desc = "Add cursor below" }
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
}
