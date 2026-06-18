vim.filetype.add {
  filename = {
    ["todo.txt"] = "todotxt",
    ["done.txt"] = "todotxt",
  },
}

return {
  -- {
  --   "freitass/todo.txt-vim",
  -- },
  {
    "phrmendes/todotxt.nvim",
    opts = {
      todotxt = vim.env.HOME .. "/todo.txt",
      donetxt = vim.env.HOME .. "/done.txt",
      max_priority = "C",
      metadata = {
        tag = { sort = "asc" },
        due = { sort = "asc" },
      },
      ghost_text = {
        enable = false,
      },
    },
    keys = {
      -- stylua: ignore start
      { "<localleader>sx", function() require("todotxt").sort_tasks() end, desc = "sort", ft = "todotxt" },
      { "<localleader>sa", function() require("todotxt").sort_tasks_by_priority() end, desc = "sort prio", ft = "todotxt" },
      { "<localleader>sp", function() require("todotxt").sort_tasks_by_project() end, desc = "sort proj", ft = "todotxt" },
      { "<localleader>sc", function() require("todotxt").sort_tasks_by_context() end, desc = "sort context", ft = "todotxt" },
      { "<localleader>sd", function() require("todotxt").sort_tasks_by_due_date() end, desc = "sort due", ft = "todotxt" },
      { "<localleader><localleader>", function() require("todotxt").toggle_todo_state() end, desc = "toggle todo state", ft = "todotxt"},
      { "<leader>to", function() require("todotxt").toggle_todotxt() end, desc = "toggle_todotxt"},
      { "<leader>td", function() require("todotxt").toggle_donetxt() end, desc = "toggle_donetxt"},
      { "<leader>tc", function() require("todotxt").capture() end, desc = "new todo"},
      -- stylua: ignore end
    },
  },
}
