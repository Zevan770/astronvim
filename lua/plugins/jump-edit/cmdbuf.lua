-- if true then return {} end
---@type LazySpec
return {
  "notomo/cmdbuf.nvim",
  keys = {
    {
      "q:",
      function()
        require("cmdbuf").split_open(vim.o.cmdwinheight)
        vim.api.nvim_feedkeys(vim.keycode "<C-c>", "n", true)
      end,
      { noremap = true, silent = true },
    },
    {
      mode = "c",
      "<C-f>",
      function()
        vim.api.nvim_feedkeys(vim.keycode "<Esc>", "n", true)
        vim.schedule(
          function()
            require("cmdbuf").split_open(
              vim.o.cmdwinheight,
              { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() }
            )
          end
        )
      end,
      { noremap = true, silent = true },
    },
    {
      "ql",
      function() require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "lua/cmd" }) end,
      { noremap = true, silent = true },
    },
    {
      "q/",
      function() require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "vim/search/forward" }) end,
      { noremap = true, silent = true },
    },
    {
      "q?",
      function() require("cmdbuf").split_open(vim.o.cmdwinheight, { type = "vim/search/backward" }) end,
      { noremap = true, silent = true },
    },
  },
  config = function()
    -- Custom buffer mappings
    vim.api.nvim_create_autocmd({ "User" }, {
      group = vim.api.nvim_create_augroup("cmdbuf_setting", {}),
      pattern = { "CmdbufNew" },
      callback = function(args)
        vim.bo.bufhidden = "wipe" -- if you don't need previous opened buffer state
        vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
        vim.keymap.set("n", "dd", [[<Cmd>lua require('cmdbuf').delete()<CR>]], { buffer = true })
        vim.keymap.set(
          { "n", "i" },
          "<C-c>",
          function() return require("cmdbuf").cmdline_expr() end,
          { buffer = true, expr = true }
        )

        local typ = require("cmdbuf").get_context().type
        if typ == "vim/cmd" then
          -- you can filter buffer lines
          local lines = vim
            .iter(vim.api.nvim_buf_get_lines(args.buf, 0, -1, false))
            :filter(function(line) return line ~= "q" end)
            :totable()
          vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
        end
      end,
    })
  end,
}
