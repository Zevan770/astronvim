---@type LazySpec
return {
  {
    "glacambre/firenvim",

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    module = false,
    build = function() vim.fn["firenvim#install"](0) end,
  },
  -- disable these plugin when started by firenvim
  -- { "folke/noice.nvim", optional = true, cond = not vim.g.started_by_firenvim },
  {
    "rebelot/heirline.nvim",
    optional = true,
    enable = not vim.g.started_by_firenvim,
  },

  {
    "wallpants/ghost-text.nvim",
    opts = {
      -- config goes here
    },
  },
}
