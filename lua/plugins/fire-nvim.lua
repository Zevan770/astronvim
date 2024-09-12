if true then return {} end
if vim.g.started_by_firenvim then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.opt.showtabline = 0
      vim.opt.laststatus = 0
    end,
  })
end

---@type LazySpec
return {
  {
    "glacambre/firenvim",

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    module = false,
    build = function() vim.fn["firenvim#install"](0) end,
    dependencies = {
      -- disable these plugin when started by firenvim
      -- { "folke/noice.nvim", optional = true, cond = not vim.g.started_by_firenvim },
      {
        "rebelot/heirline.nvim",
        optional = true,
        cond = not vim.g.started_by_firenvim,
      },
      {
        "wallpants/ghost-text.nvim",
        opts = {
          -- config goes here
        },
        cond = not vim.g.started_by_firenvim,
        optional = true,
      },
    },
    opts = function(self, opts)
      vim.g.firenvim_config = {
        globalSettings = { alt = "all" },
        localSettings = {
          [".*"] = {
            cmdline = "neovim",
            --content  = "text",
            --priority = 0,
            -- selector = "textarea",
            takeover = "never",
          },
        },
      }
    end,
  },
}
