return {
  -- {
  --   "freitass/todo.txt-vim",
  -- },
  {
    "phrmendes/todotxt.nvim",
    init = function()
      vim.filetype.add {
        filename = {
          ["todo.txt"] = "todotxt",
          ["done.txt"] = "todotxt",
        },
      }
    end,
    opts = {
      todotxt = vim.env.HOME .. "/todo.txt",
      donetxt = vim.env.HOME .. "/done.txt",
      max_priority = "C",
      metadata = {
        tag = { sort = "asc" },
        due = { sort = "asc" },
      },
      ghost_text = {
        enable = true,
        mappings = {
          ["(A)"] = "today",
          ["(B)"] = "tomorrow",
          ["(C)"] = "this week",
        },
      },
    },
  },
}
