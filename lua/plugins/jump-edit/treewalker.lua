return {
  {
    "aaronik/treewalker.nvim",

    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = "CursorLine",
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          -- 在normal和visual模式添加映射
          for _, mode in ipairs { "n", "v" } do
            maps[mode]["<C-K>"] = { "<cmd>Treewalker Up<cr>", desc = "Treewalker Up" }
            maps[mode]["<C-J>"] = { "<cmd>Treewalker Down<cr>", desc = "Treewalker Down" }
            maps[mode]["<C-H>"] = { "<cmd>Treewalker Left<cr>", desc = "Treewalker Left" }
            maps[mode]["<C-L>"] = { "<cmd>Treewalker Right<cr>", desc = "Treewalker Right" }
          end
        end,
      },
    },
  },
}
