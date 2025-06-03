return {
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
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
