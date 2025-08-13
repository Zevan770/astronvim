return {
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
    opts = {

      skipInsignificantPunctuation = true,
      consistentOperatorPending = true, -- see the README for details
      subwordMovement = true,
      customPatterns = {}, -- see the README for details
    },
    dependencies = {
      -- "https://github.com/starwing/luautf8",
      {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        opts_extend = { "rocks" },
        opts = {
          rocks = { "luautf8" },
        },
      },
    },
  },

  {
    "kkew3/jieba.vim",
    tag = "v1.0.5",
    enabled = false,
    build = "bash ./build.sh",
    init = function()
      vim.g.jieba_vim_lazy = 1
      vim.g.jieba_vim_keymap = 1
    end,
  },
}
